//
//  RunDetailCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 7/2/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import MapKit

//  MARK: - Run Detail Type

enum RunDetailType {
    
    case newRun
    case previousRun(run: Run)
    
}

//  MARK: - Run Detail Coordinator Delegate

protocol RunDetailCoordinatorDelegate: class {
    
    func didTapCloseButton(runDetailCoordinator: RunDetailCoordinator)
    
}

//  MARK: - Run Detail Coordinator

class RunDetailCoordinator: NSObject, RootViewCoordinator {
    
    //  MARK: - Properties
    
    var services: Services
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    private lazy var runDetailViewController: RunDetailViewController = {
        let runDetailViewController = self.navigationController.viewControllers
            .filter({ $0.self is RunDetailViewController })
            .first as! RunDetailViewController
        return runDetailViewController
    }()
    
    weak var delegate: RunDetailCoordinatorDelegate?
    
    let run: Run
    private let type: RunDetailType
    private var running = false
    private var newRun = false
    private var timer: Timer?
    private var seconds: Int = 0
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private lazy var measurementFormatter = MeasurementFormatter()
    private lazy var dateFormatter = DateComponentsFormatter()
    private lazy var locationList = [CLLocation]()
    
    // MARK: - Init
    
    init(with services: Services, delegate: RunDetailCoordinatorDelegate, type: RunDetailType) {
        self.services = services
        self.delegate = delegate
        self.type = type
        switch type {
        case .previousRun(let run):
            self.run = run
        default:
            self.run = Run()
        }
    }
    
    // MARK: - Functions
    
    func start() {
        let storyboard = UIStoryboard(.RunDetail)
        let viewController: RunDetailViewController = storyboard.instantiateViewController()
        configureAndPresent(viewController: viewController)
        services.location.manager.delegate = self
    }
    
    private func configureAndPresent(viewController: RunDetailViewController) {
        viewController.type = type
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    private func setButtonTitle() {
        let title = running ?  "Continue" : "Stop"
        runDetailViewController.startStopButton.setTitle(title, for: .normal)
    }
    
    private func startRun() {
        running = true
        updateDisplay()
        startLocationUpdates()
        startTimer()
    }
    
    private func stopRun() {
        running = false
        updateDisplay()
        stopLocationUpdates()
        stopTimer()
        askUserIfDone()
    }
    
    private func saveRun() {
        run.id = services.realm.objects(Run.self).count
        run.duration = seconds
        run.distance = distance.value
        
        for location in locationList {
            let locationObject = Location(latitude: location.coordinate.latitude,
                                          longitude: location.coordinate.longitude,
                                          timestamp: location.timestamp, run: run)
            run.locations.append(locationObject)
        }
        
        try! services.realm.write {
            services.realm.add(run)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func startLocationUpdates() {
        services.location.manager.delegate = self
        services.location.manager.activityType = .fitness
        services.location.manager.distanceFilter = 10
        services.location.manager.startUpdatingLocation()
    }
    
    private func stopLocationUpdates() {
        services.location.manager.stopUpdatingLocation()
    }
    
    private func askUserIfDone() {
        let alertController = UIAlertController(title: "Nice Run!",
                                                message: "Want to keep going?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Continue Run", style: .default) { _ in
            self.running = true
            self.startTimer()
            self.startLocationUpdates()
        })
        alertController.addAction(UIAlertAction(title: "Stop and Save", style: .default) { _ in
            self.saveRun()
            self.didTapCloseButton()
        })
        alertController.addAction(UIAlertAction(title: "Discard Run", style: .destructive) { _ in
            self.didTapCloseButton()
        })
        
        rootViewController.present(alertController, animated: true)
    }
    
    private func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        updateDistanceLabel()
        updateDurationLabel()
        setButtonTitle()
    }
    
    private func updateDistanceLabel() {
        let formattedDistance = measurementFormatter.string(from: distance)
        runDetailViewController.distanceLabel.text = "Distance: \(formattedDistance)"
    }
    
    private func updateDurationLabel() {
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        let formattedTime = dateFormatter.string(from: TimeInterval(seconds))!
        runDetailViewController.timeLabel.text = "Time: \(formattedTime)"
    }
    
}

// MARK: - Run Detail View Controller Delegate

extension RunDetailCoordinator: RunDetailViewControllerDelegate {
    
    func didTapStartStopButton() {
        if running {
            stopLocationUpdates()
            stopTimer()
            askUserIfDone()
        } else {
            startRun()
        }
    }
    
    func didTapCloseButton() {
        delegate?.didTapCloseButton(runDetailCoordinator: self)
    }
    
}

// MARK: - Location Manager Delegate

extension RunDetailCoordinator: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                
                runDetailViewController.updateMap(with: coordinates, newLocation: newLocation)
            }
            
            locationList.append(newLocation)
        }
    }
    
}

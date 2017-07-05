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
    
    private var runDetailViewController: RunDetailViewController?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
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
        case .newRun:
            self.run = Run()
        }
    }
    
    // MARK: - Functions
    
    func start() {
        let storyboard = UIStoryboard(.RunDetail)
        let viewController: RunDetailViewController = storyboard.instantiateViewController()
        configureAndPresent(viewController: viewController)
    }
    
    private func configureAndPresent(viewController: RunDetailViewController) {
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    private func updateButtonTitle(for viewController: RunDetailViewController) {
        let title = running ?  "Continue" : "Stop"
        viewController.startStopButton.setTitle(title, for: .normal)
    }
    
    private func startRun(_ viewController: RunDetailViewController) {
        let noLocation = CLLocationCoordinate2D()
        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        viewController.mapView.setRegion(viewRegion, animated: false)
        continueRun(viewController)
    }
    
    private func stopRun(_ viewController: RunDetailViewController) {
        running = false
        updateDisplay(for: viewController)
        stopLocationUpdates()
        stopTimer()
        askUserIfDone(with: viewController)
    }
    
    private func continueRun(_ viewController: RunDetailViewController) {
        running = true
        updateDisplay(for: viewController)
        startLocationUpdates(viewController)
        startTimer(viewController)
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
    
    private func startTimer(_ viewController: RunDetailViewController) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond(viewController)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func requestLocationAccess() {
        services.location.manager.requestWhenInUseAuthorization()
    }
    
    private func setUpLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            services.location.manager.delegate = self
            services.location.manager.desiredAccuracy = kCLLocationAccuracyBest
            services.location.manager.activityType = .fitness
            services.location.manager.distanceFilter = 10
        }
    }
    
    private func startLocationUpdates(_ viewController: RunDetailViewController) {
        if CLLocationManager.locationServicesEnabled() {
            services.location.manager.startUpdatingLocation()
        } else {
            askUserToEnableLocationServices(with: viewController)
        }
    }
    
    private func stopLocationUpdates() {
        services.location.manager.stopUpdatingLocation()
    }
    
    private func askUserToEnableLocationServices(with viewController: RunDetailViewController) {
        let alertController = UIAlertController(title: "Oh no!",
                                                message: "Looks like we can't access your location. Please enable location services for Victory in your Settings app.",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue Run", style: .cancel))
        
        viewController.present(alertController, animated: true)
    }
    
    private func askUserIfDone(with viewController: RunDetailViewController) {
        let alertController = UIAlertController(title: "Nice Run!",
                                                message: "Want to keep going?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Continue Run", style: .default) { _ in
            self.running = true
            self.startTimer(viewController)
            self.startLocationUpdates(viewController)
        })
        alertController.addAction(UIAlertAction(title: "Stop and Save", style: .default) { _ in
            self.saveRun()
            self.didTapCloseButton()
        })
        alertController.addAction(UIAlertAction(title: "Discard Run", style: .destructive) { _ in
            self.didTapCloseButton()
        })
        
        viewController.present(alertController, animated: true)
    }
    
    private func eachSecond(_ viewController: RunDetailViewController) {
        seconds += 1
        updateDisplay(for: viewController)
    }
    
    private func updateDisplay(for viewController: RunDetailViewController) {
        updateDistanceLabel(for: viewController)
        updateDurationLabel(for: viewController)
        updateButtonTitle(for: viewController)
    }
    
    private func updateDistanceLabel(for viewController: RunDetailViewController) {
        let formattedDistance = measurementFormatter.string(from: distance)
        viewController.distanceLabel.text = "Distance: \(formattedDistance)"
    }
    
    private func updateDurationLabel(for viewController: RunDetailViewController) {
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.unitsStyle = .positional
        dateFormatter.zeroFormattingBehavior = .pad
        let formattedTime = dateFormatter.string(from: TimeInterval(seconds))!
        viewController.timeLabel.text = "Time: \(formattedTime)"
    }
    
}

// MARK: - Run Detail View Controller Delegate

extension RunDetailCoordinator: RunDetailViewControllerDelegate {
    
    func viewDidLoad(_ viewController: RunDetailViewController) {
        viewController.mapView.delegate = self
        setUI(for: viewController)
        setUpLocationManager()
    }
    
    func didTapStartStopButton(_ viewController: RunDetailViewController) {
        if running {
            stopLocationUpdates()
            stopTimer()
            askUserIfDone(with: viewController)
        } else {
            startRun(viewController)
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
            
            if let lastLocation = locationList.last,
                let viewController = runDetailViewController {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                
                updateMap(on: viewController, with: coordinates, newLocation: newLocation)
            }
            
            locationList.append(newLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            setUpLocationManager()
        default:
            guard let viewController = runDetailViewController else { return }
            askUserToEnableLocationServices(with: viewController)
        }
    }
    
}

// MARK: - Map View Delegate

extension RunDetailCoordinator: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        renderer.lineWidth = 3
        return renderer
    }
    
}

// MARK: - View Controller Functions

extension RunDetailCoordinator {
    
    private func setUI(for viewController: RunDetailViewController) {
        viewController.navigationItem.leftBarButtonItem = viewController.closeBarButtonItem
        
        viewController.view.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        viewController.distanceLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.startStopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        viewController.startStopButton.backgroundColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
        
        switch type {
        case .previousRun(let run):
            viewController.title = run.date.pretty
            viewController.distanceLabel.text = "\(run.distance) miles"
            viewController.timeLabel.text = "\(run.duration)"
            viewController.startStopButton.isEnabled = false
            viewController.startStopButton.isHidden = true
            loadMap(for: viewController, run: run)
        case .newRun(_):
            viewController.title = "Let's go!"
            viewController.distanceLabel.text = "Distance"
            viewController.timeLabel.text = "Duration"
            viewController.startStopButton.isEnabled = true
            viewController.startStopButton.isHidden = false
            viewController.startStopButton.setTitle("Start", for: .normal)
        }
    }
    
}

// MARK: - Map Functions

extension RunDetailCoordinator {
    
    func updateMap(on viewController: RunDetailViewController, with coordinates: [CLLocationCoordinate2D], newLocation: CLLocation) {
        viewController.mapView.add(MKPolyline(coordinates: coordinates, count: 2))
        let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500)
        viewController.mapView.setRegion(region, animated: true)
    }
    
    private func loadMap(for viewController: RunDetailViewController, run: Run) {
        let locations = run.locations
        guard
            locations.count > 0,
            let region = mapRegion(for: run)
            else {
                let alert = UIAlertController(title: "Whoops!",
                                              message: "Looks like there aren't any locations for this run.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Weird", style: .cancel))
                viewController.present(alert, animated: true)
                return
        }
        
        viewController.mapView.setRegion(region, animated: true)
        viewController.mapView.addOverlays(polyLine())
    }
    
    private func mapRegion(for run: Run) -> MKCoordinateRegion? {
        let locations = run.locations
        
        guard locations.count > 0 else { return nil }
        
        let latitudes = locations.map { location -> Double in
            return location.latitude
        }
        
        let longitudes = locations.map { location -> Double in
            return location.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                            longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                    longitudeDelta: (maxLong - minLong) * 1.3)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    private func polyLine() -> [MKPolyline] {
        let locations = run.locations
        var coordinates: [(CLLocation, CLLocation)] = []
        
        for (first, second) in zip(locations, locations.dropFirst()) {
            let start = CLLocation(latitude: first.latitude, longitude: first.longitude)
            let end = CLLocation(latitude: second.latitude, longitude: second.longitude)
            coordinates.append((start, end))
        }
        
        var segments: [MKPolyline] = []
        for (start, end) in coordinates {
            let coords = [start.coordinate, end.coordinate]
            let segment = MKPolyline(coordinates: coords, count: 2)
            segments.append(segment)
        }
        
        return segments
    }
    
}

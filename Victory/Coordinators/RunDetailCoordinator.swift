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
    func didSaveRun(_ run: Run)
    
}

//  MARK: - Run Detail Coordinator

class RunDetailCoordinator: NSObject, RootViewCoordinator {
    
    //  MARK: - Properties
    
    var services: Services
    var childCoordinators: [Coordinator] = []
    private weak var delegate: RunDetailCoordinatorDelegate?
    private var runDetailViewController: RunDetailViewController?
    private let type: RunDetailType
    private var running = false
    private var newRun = false
    private var timer: Timer?
    private var duration: Int = 0
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private lazy var locationList = [CLLocation]()
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Init
    
    init(with services: Services, delegate: RunDetailCoordinatorDelegate, type: RunDetailType) {
        self.services = services
        self.delegate = delegate
        self.type = type
    }
    
    // MARK: - General Functions
    
    func start() {
        guard
            let storyboard = try? UIStoryboard(.RunDetail),
            let viewController: RunDetailViewController = try? storyboard.instantiateViewController()
            else { return }
        configureAndPresent(viewController: viewController)
    }
    
    private func configureAndPresent(viewController: RunDetailViewController) {
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Run Functions
    
    private func startRun(_ viewController: RunDetailViewController) {
        viewController.mapView.removeOverlays(viewController.mapView.overlays)
        locationList.removeAll()
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
        let run = Run()
        run.duration = duration
        run.distance = Int(distance.value)
        
        for location in locationList {
            let locationObject = Location(latitude: location.coordinate.latitude,
                                          longitude: location.coordinate.longitude,
                                          timestamp: location.timestamp, run: run)
            run.locations.append(locationObject)
        }
        
        delegate?.didSaveRun(run)
        
        do {
            try services.av.playSound()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Timer Functions
    
    private func startTimer(_ viewController: RunDetailViewController) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond(viewController)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func eachSecond(_ viewController: RunDetailViewController) {
        duration += 1
        updateDisplay(for: viewController)
    }
    
    // MARK: - Location Functions
    
    private func requestLocationAccess() {
        services.location.manager.requestAlwaysAuthorization()
    }
    
    private func setUpLocationManager() {
        services.location.manager.delegate = self
        services.location.manager.distanceFilter = 1
        services.location.manager.activityType = .fitness
        services.location.manager.allowsBackgroundLocationUpdates = true
        services.location.manager.desiredAccuracy = kCLLocationAccuracyBest
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
    
}

// MARK: - View Controller Functions

extension RunDetailCoordinator {
    
    private func setSharedUI(for viewController: RunDetailViewController) {
        viewController.navigationItem.leftBarButtonItem = viewController.closeBarButtonItem
        viewController.view.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        viewController.distanceLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewController.startStopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        viewController.startStopButton.backgroundColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
    }
    
    private func setPreviousRunUI(for viewController: RunDetailViewController, previousRun: Run) {
        viewController.title = previousRun.date.prettyDate
        duration = previousRun.duration
        distance = Measurement<UnitLength>(value: Double(previousRun.distance), unit: UnitLength.meters)
        let formattedTimeString = services.formatter.formatted(time: TimeInterval(duration))
        let formattedDistanceString = services.formatter.formatted(measurement: distance)
        viewController.timeLabel.text = "Time: \(formattedTimeString)"
        viewController.distanceLabel.text = "Distance: \(formattedDistanceString)"
        viewController.startStopButton.isEnabled = false
        viewController.startStopButton.isHidden = true
        loadMap(for: viewController, run: previousRun)
    }
    
    private func setNewRunUI(for viewController: RunDetailViewController) {
        viewController.title = "Let's go!"
        viewController.distanceLabel.text = "Distance"
        viewController.timeLabel.text = "Time"
        viewController.startStopButton.isEnabled = true
        viewController.startStopButton.isHidden = false
        viewController.startStopButton.setTitle("Start", for: .normal)
    }
    
    private func setUpMapView(for viewController: RunDetailViewController) {
        viewController.mapView.delegate = self
        viewController.mapView.showsUserLocation = true
        viewController.mapView.showsBuildings = true
    }
    
    private func askUserToEnableLocationServices(with viewController: RunDetailViewController) {
        let alertController = UIAlertController(title: "Oh no!",
                                                message: "Looks like we can't access your location. Please enable location services for Victory in your Settings app.",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        viewController.present(alertController, animated: true)
    }
    
    private func askUserIfDone(with viewController: RunDetailViewController) {
        let alertController = UIAlertController(title: "Nice Run!",
                                                message: "Want to keep going?",
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Continue Run", style: .default) { _ in
            self.continueRun(viewController)
        })
        alertController.addAction(UIAlertAction(title: "Stop and Save", style: .default) { _ in
            self.saveRun()
            self.delegate?.didTapCloseButton(runDetailCoordinator: self)
        })
        alertController.addAction(UIAlertAction(title: "Discard Run", style: .destructive) { _ in
            self.delegate?.didTapCloseButton(runDetailCoordinator: self)
        })
        
        viewController.present(alertController, animated: true)
    }
    
    private func updateDisplay(for viewController: RunDetailViewController) {
        updateDistanceLabel(for: viewController)
        updateTimeLabel(for: viewController)
        updateButtonTitle(for: viewController)
    }
    
    private func updateDistanceLabel(for viewController: RunDetailViewController) {
        let formattedDistance = services.formatter.formatted(measurement: distance)
        viewController.distanceLabel.text = "Distance: \(formattedDistance)"
    }
    
    private func updateTimeLabel(for viewController: RunDetailViewController) {
        let formattedTime = services.formatter.formatted(time: TimeInterval(duration))
        viewController.timeLabel.text = "Time: \(formattedTime)"
    }
    
    private func updateButtonTitle(for viewController: RunDetailViewController) {
        let title = running ?  "Stop" : "Continue"
        viewController.startStopButton.setTitle(title, for: .normal)
    }
    
}

// MARK: - Run Detail View Controller Delegate

extension RunDetailCoordinator: RunDetailViewControllerDelegate {
    
    func viewDidLoad(_ viewController: RunDetailViewController) {
        runDetailViewController = viewController
        setSharedUI(for: viewController)
        
        switch type {
        case .previousRun(let run):
            setPreviousRunUI(for: viewController, previousRun: run)
        case .newRun:
            setNewRunUI(for: viewController)
        }
        
        requestLocationAccess()
        setUpLocationManager()
        setUpMapView(for: viewController)
    }
    
    func didTapStartStopButton(on viewController: RunDetailViewController) {
        if running {
            running = false
            stopLocationUpdates()
            stopTimer()
            askUserIfDone(with: viewController)
        } else {
            startRun(viewController)
        }
    }
    
    func didTapCloseButton(on viewController: RunDetailViewController) {
        if running {
            askUserIfDone(with: viewController)
        } else {
            delegate?.didTapCloseButton(runDetailCoordinator: self)
            viewController.mapView.removeOverlays(viewController.mapView.overlays)
        }
    }
    
}

// MARK: - Location Manager Delegate

extension RunDetailCoordinator: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            guard newLocation.horizontalAccuracy < 20
                else { continue }
            
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
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        switch type {
        case .newRun:
            if !running {
                let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200)
                mapView.setRegion(region, animated: true)
            }
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MulticolorPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = polyline.color
            renderer.lineWidth = 3
            return renderer
        } else if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

// MARK: - Map Functions

extension RunDetailCoordinator {
    
    func updateMap(on viewController: RunDetailViewController, with coordinates: [CLLocationCoordinate2D], newLocation: CLLocation) {
        viewController.mapView.add(MKPolyline(coordinates: coordinates, count: 2))
        let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 200, 200)
        viewController.mapView.setRegion(region, animated: true)
    }
    
    private func loadMap(for viewController: RunDetailViewController, run: Run) {
        guard
            run.locations.count > 0,
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
        viewController.mapView.addOverlays(polyLine(for: run))
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
        
        let maxLat = latitudes.max() ?? 0.0
        let minLat = latitudes.min() ?? 0.0
        let maxLong = longitudes.max() ?? 0.0
        let minLong = longitudes.min() ?? 0.0
        
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2,
                                            longitude: (minLong + maxLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3,
                                    longitudeDelta: (maxLong - minLong) * 1.3)
        return MKCoordinateRegion(center: center, span: span)
    }
    
    private func polyLine(for run: Run) -> [MulticolorPolyline] {
        let locations = run.locations
        var coordinates: [(CLLocation, CLLocation)] = []
        var speeds: [Double] = []
        var minSpeed = Double.greatestFiniteMagnitude
        var maxSpeed = 0.0
        
        for (first, second) in zip(locations, locations.dropFirst()) {
            let start = CLLocation(latitude: first.latitude, longitude: first.longitude)
            let end = CLLocation(latitude: second.latitude, longitude: second.longitude)
            coordinates.append((start, end))
            
            let distance = end.distance(from: start)
            let time = second.timestamp.timeIntervalSince(first.timestamp as Date)
            let speed = time > 0 ? distance / time : 0
            speeds.append(speed)
            minSpeed = min(minSpeed, speed)
            maxSpeed = max(maxSpeed, speed)
        }
        
        let midSpeed = speeds.reduce(0, +) / Double(speeds.count)
        
        var segments: [MulticolorPolyline] = []
        for ((start, end), speed) in zip(coordinates, speeds) {
            let coordinates = [start.coordinate, end.coordinate]
            let segment = MulticolorPolyline(coordinates: coordinates, count: 2)
            segment.color = UIColor.performanceColor(value: Int(speed),
                                                     low: Int(minSpeed),
                                                     mid: Int(midSpeed),
                                                     high: Int(maxSpeed))
            segments.append(segment)
        }
        return segments
    }
    
}

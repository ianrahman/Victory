//
//  RunDetailViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Run Detail View Controller Delegate

protocol RunDetailViewControllerDelegate {
    
    func didTapStartStopButton()
    func didTapCloseButton()
    
}

// MARK: - Run Detail View Controller

final class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    weak var coordinator: RunDetailCoordinator? {
        didSet {
            self.run = coordinator?.run
        }
    }
    
    var type: RunDetailType?
    var run: Run?
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        return closeBarButtonItem
    }()
    
    // MARK: - Actions
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        coordinator?.didTapStartStopButton()
    }
    
    @objc private func didTapCloseButton() {
        coordinator?.didTapCloseButton()
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        mapView.delegate = self
        setUI()
    }
    
    private func setUI() {
        navigationItem.leftBarButtonItem = closeBarButtonItem
        
        view.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        distanceLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        startStopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        startStopButton.backgroundColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
        
        guard let type = type else { return }
        
        switch type {
        case .previousRun(let run):
            title = run.date.pretty
            distanceLabel.text = "\(run.distance) miles"
            timeLabel.text = "\(run.duration)"
            startStopButton.isEnabled = false
            startStopButton.isHidden = true
            loadMap(for: run)
        case .newRun(_):
            title = "Let's go!"
            distanceLabel.text = "Distance"
            timeLabel.text = "Duration"
            startStopButton.isEnabled = true
            startStopButton.isHidden = false
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
}

// MARK: - Map Functions

extension RunDetailViewController {
    
    func updateMap(with coordinates: [CLLocationCoordinate2D], newLocation: CLLocation) {
        mapView.add(MKPolyline(coordinates: coordinates, count: 2))
        let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }
    
    private func loadMap(for run: Run) {
        let locations = run.locations
        guard
            locations.count > 0,
            let region = mapRegion(for: run)
            else {
                let alert = UIAlertController(title: "Whoops!",
                                              message: "Looks like there aren't any locations for this run.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Weird", style: .cancel))
                present(alert, animated: true)
                return
        }
        
        mapView.setRegion(region, animated: true)
        mapView.addOverlays(polyLine())
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
        guard let locations = run?.locations else { return [] }
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

// MARK: - Map View Delegate

extension RunDetailViewController: MKMapViewDelegate {
    
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

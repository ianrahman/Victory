//
//  RunDetailViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import MapKit

final class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    
    // MARK: - Functions
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
    }
    
    
    // TODO: - Finish implementation
    func layout(for run: Run) {
        title = "\(run.date)"
        distanceLabel.text = "\(run.distance)"
        timeLabel.text = "\(run.duration)"
    }
    
}

extension RunDetailViewController: DependencyInjectableVC { }

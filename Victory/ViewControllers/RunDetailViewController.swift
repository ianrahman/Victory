//
//  RunDetailViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import MapKit

class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Functions
    
    // TODO: - Finish implementation
    func layout(for run: Run) {
        distanceLabel.text = String(run.distance)
        timeLabel.text = String(run.duration)
//        dateLabel.text = String(run.locations[0].timestamp)
    }
    
}


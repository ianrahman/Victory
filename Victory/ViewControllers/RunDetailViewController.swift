//
//  RunDetailViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import MapKit

protocol RunDetailViewControllerDelegate {
    
    func startStopButtonTapped()
    
}

final class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: RunDetailCoordinator?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
        return closeBarButtonItem
    }()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        
    }
    
    @objc private func closeButtonTapped() {
        
    }
    
    // TODO: - Finish implementation
    func layout(for run: Run) {
        title = "\(run.date)"
        distanceLabel.text = "\(run.distance)"
        timeLabel.text = "\(run.duration)"
    }
    
}

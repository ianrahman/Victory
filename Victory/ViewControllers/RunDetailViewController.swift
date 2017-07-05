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
    
    func viewDidLoad(_ viewController: RunDetailViewController)
    func didTapStartStopButton(_ viewController: RunDetailViewController)
    func didTapCloseButton()
    
}

// MARK: - Run Detail View Controller

final class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: RunDetailCoordinator?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        return closeBarButtonItem
    }()
    
    // MARK: - Actions
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        coordinator?.didTapStartStopButton(self)
    }
    
    @objc private func didTapCloseButton() {
        coordinator?.didTapCloseButton()
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        coordinator?.viewDidLoad(self)
    }
    
}

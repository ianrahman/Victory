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
    func closeButtonTapped()
    
}

final class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    weak var coordinator: RunDetailCoordinator?
    
    var type: RunDetailType?
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
        closeBarButtonItem.tintColor = .white
        return closeBarButtonItem
    }()
    
    // MARK: - Actions
    
    @IBAction func startStopButtonTapped(_ sender: Any) {
        coordinator?.startStopButtonTapped()
    }
    
    @objc private func didTapCloseButton() {
        coordinator?.closeButtonTapped()
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        layoutViewController()
    }
    
    private func layoutViewController() {
        navigationItem.leftBarButtonItem = closeBarButtonItem
        guard let type = type else { return }
        switch type {
        case .previousRun(let run):
            title = "\(run.date)"
            distanceLabel.text = "\(run.distance) mi"
            timeLabel.text = "\(run.duration)"
            paceLabel.text = "pace in space"
            startStopButton.isEnabled = false
            startStopButton.isHidden = true
        case .newRun:
            break
        }
    }
    
}

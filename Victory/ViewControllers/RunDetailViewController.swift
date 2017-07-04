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
    @IBOutlet weak var startStopButton: UIButton!
    
    weak var coordinator: RunDetailCoordinator?
    
    var type: RunDetailType?
    
    lazy var closeBarButtonItem: UIBarButtonItem = {
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(didTapCloseButton))
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
        view.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        distanceLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        timeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        startStopButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        startStopButton.backgroundColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
        
        guard let type = type else { return }
        
        switch type {
        case .previousRun(let run):
            title = run.date.pretty
            distanceLabel.text = "\(run.distance) mi"
            timeLabel.text = "\(run.duration)"
            startStopButton.isEnabled = false
            startStopButton.isHidden = true
        case .newRun:
            title = "Let's go!"
        }
    }
    
}

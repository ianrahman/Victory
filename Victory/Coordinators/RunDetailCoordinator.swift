//
//  RunDetailCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 7/2/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

enum RunDetailType {
    
    case newRun
    case previousRun(run: Run)
    
}

protocol RunDetailCoordinatorDelegate: class {
    
    func closeButtonTapped(runDetailCoordinator: RunDetailCoordinator)
    
}

class RunDetailCoordinator: RootViewCoordinator {
    
    //  MARK: - Properties
    
    var services: Services
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: RunDetailCoordinatorDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    let type: RunDetailType
    var run: Run?
    var running = false
    var newRun = false
    
    // MARK: - Init
    
    init(with services: Services, delegate: RunDetailCoordinatorDelegate, type: RunDetailType) {
        self.services = services
        self.delegate = delegate
        self.type = type
    }
    
    // MARK: - Functions
    
    func start() {
        let storyboard = UIStoryboard(.RunDetail)
        let viewController: RunDetailViewController = storyboard.instantiateViewController()
        configureAndPresent(viewController: viewController, run: run)
    }
    
    private func configureAndPresent(viewController: RunDetailViewController, run: Run?) {
        if let run = run {
            viewController.layout(for: run)
        }
        navigationController.viewControllers = [viewController]
        viewController.coordinator = self
    }
    
}

// MARK: - Run Detail View Controller Delegate

extension RunDetailCoordinator: RunDetailViewControllerDelegate {
    
    func startStopButtonTapped() {
        print("Button Tapped!")
        guard let viewController = rootViewController.presentedViewController as? RunDetailViewController else { return }
        let title = running ? "Stop" : "Start"
        running = !running
        viewController.startStopButton.setTitle(title, for: .normal)
    }
    
    func closeButtonTapped() {
        delegate?.closeButtonTapped(runDetailCoordinator: self)
    }
    
}

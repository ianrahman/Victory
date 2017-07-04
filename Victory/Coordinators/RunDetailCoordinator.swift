//
//  RunDetailCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 7/2/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

enum RunDetailType {
    
    case newRun(run: Run)
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
        configureAndPresent(viewController: viewController)
    }
    
    private func configureAndPresent(viewController: RunDetailViewController) {
        viewController.type = type
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    private func setButtonTitle() {
        guard let viewController = navigationController.viewControllers
            .filter({ $0.self is RunDetailViewController })
            .first as? RunDetailViewController else { return }
        let title = running ?  "Continue" : "Stop"
        running = !running
        viewController.startStopButton.setTitle(title, for: .normal)
    }
    
    private func updateDistance() {
        
    }
    
    private func updateDuration() {
        
    }
    
}

// MARK: - Run Detail View Controller Delegate

extension RunDetailCoordinator: RunDetailViewControllerDelegate {
    
    func startStopButtonTapped() {
        setButtonTitle()
    }
    
    func closeButtonTapped() {
        delegate?.closeButtonTapped(runDetailCoordinator: self)
    }
    
}

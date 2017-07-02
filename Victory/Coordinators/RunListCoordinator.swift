//
//  RunListCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 7/2/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol RunListCoordinatorDelegate: class {
    
    func didTapNewRunButton()
    func didTapRunCell(with run: Run)
    
}

class RunListCoordinator: RootViewCoordinator {
    
    //  MARK: - Properties
    
    var services: Services
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: RunListCoordinatorDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    let type: RunDetailType
    var run: Run?
    var running = false
    var newRun = false
    
    // MARK: - Init
    
    init(with services: Services, delegate: RunListCoordinatorDelegate, type: RunDetailType) {
        self.services = services
        self.delegate = delegate
        self.type = type
    }
    
    // MARK: - Functions
    
    func start() {
        let storyboard = UIStoryboard(.RunDetail)
        let runListViewController: RunListViewController = storyboard.instantiateViewController()
        navigationController.viewControllers = [runListViewController]
    }
    
}

extension RunListCoordinator: RunListViewControllerDelegate {
    
    func didTapNewRunButton() {
        delegate?.didTapNewRunButton()
    }
    
}

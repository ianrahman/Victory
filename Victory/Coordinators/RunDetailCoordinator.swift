//
//  RunDetailCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 7/2/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

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
    
    var run: Run!
    
    // MARK: - Init
    
    init(with services: Services) {
        self.services = services
    }
    
    // MARK: - Functions
    
    func start() {
//        guard let run = services.dataService.run else { return }
//        let vc = RunDetailViewController(run: run)
        let storyboard = UIStoryboard(.RunDetail)
        let vc: RunDetailViewController = storyboard.instantiateViewController()
        vc.layout(for: run)
        
    }
    
    
}

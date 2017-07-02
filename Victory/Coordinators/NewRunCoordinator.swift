//
//  NewRunCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol NewRunCoordinatorDelegate: class {
    
    func newRunDiscarded(newRunCoordinator: NewRunCoordinator)
    
    func newRunSaved(newRunCoordinator: NewRunCoordinator)
    
}

final class NewRunCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let services: Services
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    fileprivate lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // MARK: - Init
    
    init(with services: Services) {
        self.services = services
    }
    
    // MARK: - Functions
    
    func start() {
        let storyboard = UIStoryboard(.NewRun)
        let vc: NewRunViewController = storyboard.instantiateViewController()
        
//        let viewController = NewRunViewController(services: self.services, delegate: self)
//        self.navigationController.viewControllers = [viewController]
    }
    
    func showViewController() {
        let viewController = NewRunViewController(services: self.services, delegate: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - ViewControllerDelegate

extension NewRunCoordinator: ViewControllerDelegate {
    
    func viewControllerDidLoad(_ viewController: NewRunViewController) {
        print("View Controller Did Load")
    }
    
}



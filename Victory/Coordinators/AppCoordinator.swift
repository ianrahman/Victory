//
//  AppCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

/// The AppCoordinator is our first coordinator
final class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    
    let services: Services
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Functions
    
    /// Starts the coordinator
    public func start() {
        self.showSplashViewController()
    }
    
    /// Creates a new SplashViewController and places it into the navigation controller
    private func showSplashViewController() {
        let splashViewController = RunListViewController(services: self.services, delegate: self)
        self.navigationController.viewControllers = [splashViewController]
    }
    
}

extension AppCoordinator: ViewControllerDelegate {
    
    // TODO: Handle payloads from ViewControllers, if necessary
}

//
//  AppCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

final class AppCoordinator: RootViewCoordinator {
    
    // MARK: - Properties
    
    let services: Services
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    fileprivate lazy var navigationController: UINavigationController = {
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
    
    public func start() {
        self.showInitialViewController()
    }
    
    fileprivate func showInitialViewController() {
//        let initialViewController = RunListViewController(services: self.services, delegate: self)
//        self.navigationController.viewControllers = [initialViewController]
        
        let storyboard = UIStoryboard(.RunList)
        let vc: RunListViewController = storyboard.instantiateViewController()
        navigationController.viewControllers = [vc]
    }
    
}

extension AppCoordinator: NewRunCoordinatorDelegate {
    
    func newRunDiscarded(newRunCoordinator: NewRunCoordinator) {
        <#code#>
    }
    
    func newRunSaved(newRunCoordinator: NewRunCoordinator) {
        <#code#>
    }
    
}

extension AppCoordinator: RunDetailCoordinatorDelegate {
    
    func closeButtonTapped(runDetailCoordinator: RunDetailCoordinator) {
        <#code#>
    }
    
}

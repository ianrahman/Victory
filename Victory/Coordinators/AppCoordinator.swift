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
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
//        navigationController.isNavigationBarHidden = true
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
    
    func start() {
        self.showInitialViewController()
    }
    
    /// Populate navigation controller with initial view controller
    private func showInitialViewController() {
        let coordinator = RunListCoordinator(with: services, delegate: self)
        coordinator.start()
        
        addChildCoordinator(coordinator)
        
//        addChildCoordinator(coordinator)
//        let storyboard = UIStoryboard(.RunList)
//        let viewController: RunListViewController = storyboard.instantiateViewController()
//        navigationController.viewControllers = [viewController]
    }
    
}

// MARK: - Run List Coordinator Delegate

extension AppCoordinator: RunListCoordinatorDelegate {

    func didTapNewRunButton() {
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .newRun)
        startAndPresent(runDetailCoordinator)
    }
    
    func didTapRunCell(with run: Run) {
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .previousRun(run: run))
        startAndPresent(runDetailCoordinator)
    }
    
    private func startAndPresent(_ runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.start()
        addChildCoordinator(runDetailCoordinator)
        rootViewController.present(runDetailCoordinator.rootViewController, animated: true)
    }

}

// MARK: - Run Detail Coordinator Delegate

extension AppCoordinator: RunDetailCoordinatorDelegate {
    
    func closeButtonTapped(runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.rootViewController.dismiss(animated: true)
        removeChildCoordinator(runDetailCoordinator)
    }
    
}

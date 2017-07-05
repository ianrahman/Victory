//
//  AppCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - App Coordinator

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
        return navigationController
    }()
    
    private lazy var runListViewController: RunListViewController = {
        let runListViewController = self.navigationController.viewControllers
            .filter({ $0.self is RunListViewController })
            .first as! RunListViewController
        return runListViewController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
    }
    
    // MARK: - Functions
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showInitialViewController()
    }
    
    /// Populate navigation controller with initial view controller
    private func showInitialViewController() {
        let storyboard = UIStoryboard(.RunList)
        let viewController: RunListViewController = storyboard.instantiateViewController()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    private func setGeneralAppearance() {
        UILabel.appearance().font = services.configuration.bodyFont
    }
    
}

// MARK: - Run List View Controller Delegate

extension AppCoordinator: RunListCoordinator {

    func didTapNewRunButton() {
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .newRun)
        startAndPresent(runDetailCoordinator)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let run = services.realm.objects(Run.self)[indexPath.row]
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .previousRun(run: run))
        startAndPresent(runDetailCoordinator)
    }
    
    private func startAndPresent(_ runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.start()
        addChildCoordinator(runDetailCoordinator)
        rootViewController.present(runDetailCoordinator.rootViewController, animated: true)
    }
    
    func reloadData() {
        runListViewController.tableView.reloadData()
    }

}

// MARK: - Run Detail Coordinator Delegate

extension AppCoordinator: RunDetailCoordinatorDelegate {
    
    func didTapCloseButton(runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.rootViewController.dismiss(animated: true)
        removeChildCoordinator(runDetailCoordinator)
        reloadData()
    }
    
}

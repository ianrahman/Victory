//
//  AppCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
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
    
    /// Window to manage
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
    
    private func showSplashViewController() {
        let splashViewController = NewRunViewController(services: self.services, delegate: self)
        self.navigationController.viewControllers = [splashViewController]
    }
    
}

// MARK: - SplashViewControllerDelegate
extension AppCoordinator: ViewControllerDelegate {
    
    func viewControllerDidLoad(viewController: ViewControllerProtocol) {
        
        let newRunCoordinator = NewRunCoordinator(with: self.services)
        newRunCoordinator.delegate = self
        newRunCoordinator.start()
        self.addChildCoordinator(newRunCoordinator)
        self.rootViewController.present(newRunCoordinator.rootViewController, animated: true, completion: nil)
    }
    
}

// MARK: - NewRunCoordinatorDelegate
//extension AppCoordinator: NewRunCoordinatorDelegate {
//
//    func newRunCoordinatorDidRequestCancel(newRunCoordinator: NewOrderCoordinator) {
//
//        newRunCoordinator.rootViewController.dismiss(animated: true)
//        self.removeChildCoordinator(newRunCoordinator)
//
//    }
//
//    func newOrderCoordinator(newOrderCoordinator: NewOrderCoordinator, didAddOrder orderPayload: NewOrderCoordinatorPayload) {
//
//        guard let drinkType = orderPayload.selectedDrinkType,
//            let snackType = orderPayload.selectedSnackType else {
//                return
//        }
//
//        let order = Order(drinkType: drinkType, snackType: snackType)
//
//        self.services.dataService.orders.append(order)
//
//        newOrderCoordinator.rootViewController.dismiss(animated: true)
//        self.removeChildCoordinator(newOrderCoordinator)
//    }
//}

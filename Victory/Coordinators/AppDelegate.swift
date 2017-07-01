//
//  AppDelegate.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    let services = Services()
//    var childCoordinators: [Coordinator]?
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    // MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = self.rootViewController
        window?.makeKeyAndVisible()
        
        start()
        
        return true
    }
    
    func start() {
        self.showHomeViewController()
    }
    
    private func showHomeViewController() {
        let homeViewController = RunListViewController(services: services, delegate: self)
        self.navigationController.viewControllers = [homeViewController]
    }
    
}

// MARK: - Coordinator

//extension AppDelegate: Coordinator { }

// MARK: - ViewControllerDelegate

extension AppDelegate: ViewControllerDelegate {
    
//    func viewControllerDidLoad(viewController: ViewControllerProtocol) {
//        let newRunCoordinator = NewRunCoordinator(with: self.services)
//        newRunCoordinator.delegate = self
//        newRunCoordinator.start()
//        self.addChildCoordinator(newRunCoordinator)
//        self.rootViewController.present(newRunCoordinator.rootViewController, animated: true, completion: nil)
//    }
    
}

// MARK: - NewRunCoordinatorDelegate
//extension AppDelegate: NewRunCoordinatorDelegate {
//
//    func newRunCoordinatorDidRequestCancel(newRunCoordinator: NewRunCoordinator) {
//
//        newRunCoordinator.rootViewController.dismiss(animated: true)
//        self.removeChildCoordinator(newRunCoordinator)
//
//    }
//
//    func newRunCoordinator(newRunCoordinator: NewRunCoordinator, didAddRun runPayload: NewRunCoordinatorPayload) {
//
//        guard let drinkType = runPayload.selectedDrinkType,
//            let snackType = runPayload.selectedSnackType else {
//                return
//        }
//
//        let run = Run()
//
//        self.services.dataService.runs.append(run)
//
//        newRunCoordinator.rootViewController.dismiss(animated: true)
//        self.removeChildCoordinator(newRunCoordinator)
//    }
//}

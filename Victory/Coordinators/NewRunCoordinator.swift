////
////  NewRunCoordinator.swift
////  Victory
////
////  Created by Ian Rahman on 6/30/17.
////  Copyright © 2017 Evergreen Labs. All rights reserved.
////
//
//import UIKit
//
//final class NewRunCoordinator: Coordinator {
//    
//    // MARK: - Properties
//    
//    let services: Services
//    var childCoordinators: [Coordinator] = []
//    
//    var rootViewController: UIViewController {
//        return self.navigationController
//    }
//    
//    private lazy var navigationController: UINavigationController = {
//        let navigationController = UINavigationController()
//        return navigationController
//    }()
//    
//    // MARK: - Init
//    
//    init(with services: Services) {
//        self.services = services
//    }
//    
//    // MARK: - Functions
//    
//    func start() {
//        let viewController = ViewController(services: self.services)
//        viewController.delegate = self
//        self.navigationController.viewControllers = [viewController]
//    }
//    
//    func showViewController() {
//        let viewController = ViewController(services: self.services)
//        viewController.delegate = self
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//}
//
//// MARK: - ViewControllerDelegate
//
//extension NewRunCoordinator: ViewControllerDelegate {
//    
//    func viewControllerDidLoad(viewController: ViewController) {
//        print("View Controller Did Load")
//    }
//    
//}


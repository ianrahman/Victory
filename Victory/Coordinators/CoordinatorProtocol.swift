//
//  CoordinatorProtocol.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    
    var services: Services { get }
    var childCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController { get }
    
}

extension Coordinator {
    
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}

//
//  RootViewCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol RootViewControllerProvider: class {
    
    var rootViewController: UIViewController { get }
    
}

typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

/// The Coordinator protocol
protocol Coordinator: class {
    
    /// The services that the coordinator can use
    var services: Services { get }
    
    /// The array containing any child coordinators
    var childCoordinators: [Coordinator] { get set }
    
}

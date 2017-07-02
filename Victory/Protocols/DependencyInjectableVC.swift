//
//  DependencyInjectableVC.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// TODO: - Re-implement the following line
//protocol ViewControllerProtocol where Self: UIViewController {
protocol DependencyInjectableVC: class {
    
    /// Initialize with dependency injection
    init(services: Services, coordinator: Coordinator)
    
    var services: Services { get set }
    weak var coordinator: Coordinator? { get set }
    
}

extension DependencyInjectableVC {
    
    init(services: Services, coordinator: Coordinator) {
        self.services = services
        self.coordinator = coordinator
    }
    
}

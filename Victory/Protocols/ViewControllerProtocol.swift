//
//  ViewControllerProtocol.swift
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
    init(services: Services, delegate: ViewControllerDelegate)
    
    var services: Services { get set }
    weak var delegate: ViewControllerDelegate? { get set }
    
}

extension DependencyInjectableVC where Self: DependencyInjectableVC {
    
    init(services: Services, delegate: ViewControllerDelegate) {
        self.services = services
        self.delegate = delegate
    }
    
}

protocol ViewControllerDelegate: class { }

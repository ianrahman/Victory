//
//  RootViewCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol RootViewControllerProvider: class {
    
    var rootViewController: UIViewController { get }
    
}

typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

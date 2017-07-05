//
//  RootViewCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Root View Controller Provider

protocol RootViewControllerProvider: class {
    
    var rootViewController: UIViewController { get }
    
}

// MARK: - Root View Coordinator

typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

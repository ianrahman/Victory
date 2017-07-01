//
//  ViewControllerProtocol.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol where Self: UIViewController {
    
    init(services: Services, delegate: ViewControllerDelegate)
    var services: Services { get }
    weak var delegate: ViewControllerDelegate? { get }
    
}

protocol ViewControllerDelegate: class { }



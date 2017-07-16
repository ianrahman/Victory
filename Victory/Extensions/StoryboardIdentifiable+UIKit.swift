//
//  StoryboardIdentifiable+UIKit.swift
//  Victory
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - View Controller

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}

// MARK: - Table View Cell

extension StoryboardIdentifiable where Self: UITableViewCell {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}

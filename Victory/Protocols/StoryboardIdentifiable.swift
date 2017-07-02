//
//  StoryboardIdentifiable.swift
//  Victory
//
//  Created by Ian Rahman on 7/1/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: String { get }
    
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}

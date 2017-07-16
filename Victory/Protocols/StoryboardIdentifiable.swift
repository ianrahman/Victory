//
//  StoryboardIdentifiable.swift
//  Victory
//
//  Created by Ian Rahman on 7/1/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Storyboard Identifiable

protocol StoryboardIdentifiable {
    
    static var storyboardIdentifier: String { get }
    
}

enum StoryboardIdentifiableError: Error {
    
    case unrecognizedIdentifier
    
}

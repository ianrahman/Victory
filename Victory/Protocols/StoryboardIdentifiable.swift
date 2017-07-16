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

// MARK: - Storyboard Identifiable Error

enum StoryboardIdentifiableError: Error {
    
    case unrecognizedIdentifier
    case unrecognizedType
    
}

// MARK: - Localized Error

extension StoryboardIdentifiableError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unrecognizedIdentifier: return "Unrecognized Identifier"
        case .unrecognizedType: return "Unrecognized Type"
        }
    }
    
}

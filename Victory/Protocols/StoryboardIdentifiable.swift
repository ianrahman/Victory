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
    case unrecognizedType
    
}

extension StoryboardIdentifiableError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unrecognizedIdentifier: return "Uncrecognized Identifier"
        case .unrecognizedType: return "Uncrecognized Type"
        }
    }
    
}

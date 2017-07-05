//
//  SegueHandlerType.swift
//  Victory
//
//  Created by Ian Rahman on 7/4/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Segue Handler Type

/// Use in view controllers:
/// 1) Conform view controller to SegueHandlerType
/// 2) Add `enum SegueIdentifier: String { }` to conformance
/// 3) Manually trigger segues with `performSegue(with:sender:)`
/// 4) In `prepare(for:sender:)`, perform `switch segueIdentifier(for: segue)` to select the appropriate segue case
protocol SegueHandlerType {
    
    associatedtype SegueIdentifier: RawRepresentable
    
}

// MARK: - View Controller

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else {
                fatalError("Invalid Segue Identifier: \(String(describing: segue.identifier))")
        }
        
        return segueIdentifier
    }
    
}

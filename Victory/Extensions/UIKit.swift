//
//  UIKit.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK - UIStoryboard
extension UIStoryboard {
    
    enum Storyboard: String {
        case runList
        case runDetail
        case newRun
        
        /// The name of the storyboard's file, returned with capitalization applied.
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
}


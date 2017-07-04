//
//  UIKit.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Storyboard

extension UIStoryboard {
    
    // Enumeration of all storyboard names used in the app
    enum Storyboard: String {
        case RunList
        case RunDetail
        case NewRun
        
        /// The name of the storyboard's file, returned with capitalization applied
        var filename: String {
            return rawValue
        }
    }
    
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    /// Creates an instance of a view controller from a storyboard identifier
    /// Note: - The storyboard identifier must be set to the full view controller name
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    
}

// MARK: - View Controller

extension UIViewController: StoryboardIdentifiable { }

// MARK: - Navigation Controller

extension UINavigationController {
    
    override open func viewDidLoad() {
        self.navigationBar.barTintColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let configuration = Services().configuration
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font.rawValue: configuration.victoryTitleFont,
            NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

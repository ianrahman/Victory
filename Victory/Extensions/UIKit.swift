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
        
        /// The name of the storyboard's file, returned with capitalization applied
        var filename: String {
            return rawValue
        }
    }
    
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) throws {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    /// Creates an instance of a view controller from a storyboard identifier
    /// Note: - The storyboard identifier must be set to the full view controller name
    func instantiateViewController<T: UIViewController>() throws -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedIdentifier
            print("\(error.errorDescription): \(T.storyboardIdentifier)")
            throw error
        }
        return viewController
    }
    
}

// MARK: - Storyboard Identifiable Error

enum StoryboardIdentifiableError: Error {
    
    case unrecognizedIdentifier
    case unrecognizedType
    
}

// MARK: - Localized Error

extension StoryboardIdentifiableError: LocalizedError {
    
    public var errorDescription: String {
        switch self {
        case .unrecognizedIdentifier: return "Unrecognized Identifier"
        case .unrecognizedType: return "Unrecognized Type"
        }
    }
    
}

// MARK: - View Controller

extension UIViewController: StoryboardIdentifiable { }

// MARK: - Table View Cell

extension UITableViewCell: StoryboardIdentifiable { }

// MARK: - Table View

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) throws -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedIdentifier
            print("\(error.errorDescription): \(T.storyboardIdentifier)")
            throw StoryboardIdentifiableError.unrecognizedIdentifier
        }
        return cell
    }
    
    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) throws -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            let error = StoryboardIdentifiableError.unrecognizedType
            print("\(error.errorDescription): \(T.self)")
            throw StoryboardIdentifiableError.unrecognizedType
        }
        return cell
    }
    
}

// MARK: - Navigation Controller

extension UINavigationController {
    
    override open func viewDidLoad() {
        self.navigationBar.barTintColor = #colorLiteral(red: 0.6399999857, green: 0, blue: 0, alpha: 1)
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let configuration = Services().configuration
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font.rawValue: configuration.titleFont,
            NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

// MARK: - Color

extension UIColor {
    
    static func performanceColor(value: Int, low: Int, mid: Int, high: Int) -> UIColor {
        guard low != high, value >= low, value <= high else { return #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1) }
        
        enum BaseColors {
            static let r_red: CGFloat = 84/100
            static let r_green: CGFloat = 0
            static let r_blue: CGFloat = 0
            
            static let y_red: CGFloat = 1
            static let y_green: CGFloat = 1
            static let y_blue: CGFloat = 0
            
            static let g_red: CGFloat = 46/100
            static let g_green: CGFloat = 1
            static let g_blue: CGFloat = 1/100
        }
        
        let red, green, blue: CGFloat
        
        if value < mid {
            let ratio = CGFloat(Double(value - low) / Double(mid - low))
            red = BaseColors.r_red + ratio * (BaseColors.y_red - BaseColors.r_red)
            green = BaseColors.r_green + ratio * (BaseColors.y_green - BaseColors.r_green)
            blue = BaseColors.r_blue + ratio * (BaseColors.y_blue - BaseColors.r_blue)
        } else {
            let ratio = CGFloat(Double(value - mid) / Double(high - mid))
            red = BaseColors.y_red + ratio * (BaseColors.g_red - BaseColors.y_red)
            green = BaseColors.y_green + ratio * (BaseColors.g_green - BaseColors.y_green)
            blue = BaseColors.y_blue + ratio * (BaseColors.g_blue - BaseColors.y_blue)
        }
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

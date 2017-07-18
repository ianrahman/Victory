//
//  Foundation.swift
//  Victory
//
//  Created by Ian Rahman on 7/4/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation

// MARK: - Date

extension Date {
    
    /// Get the year from the date
    public var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// Get the month from the date
    public var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// Get the weekday from the date
    public var weekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    /// Get the month from the date
    public var monthAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    /// Get the day from the date
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// Get the hours from date
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// Get the minute from date
    public var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Get the second from the date
    public var second: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    /// Get the date as a string formatted MM/dd/yyyy
    public var prettyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    
    /// Get the year, month, day, hour, minute, and second concatinated as an Int
    public var id: Int {
        let s = "\(year)\(month)\(day)\(hour)\(minute)\(second)"
        return Int(s) ?? 0
    }
}

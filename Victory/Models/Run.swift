//
//  Run.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Run

class Run: Object {
    
    // MARK: - Init
    
    convenience init(distance: Int, duration: Int, date: Date, locations: List<Location>) {
        self.init()
        self.distance = distance
        self.duration = duration
        self.date = date
        self.locations = locations
    }
    
    // MARK: - Properties
    
    /// Meters
    @objc dynamic var distance: Int = 0
    
    /// Seconds
    @objc dynamic var duration: Int = 0
    
    /// Time run was saved
    @objc dynamic var date: Date = Date()
    
    /// Concatenation of date components
    @objc dynamic var id: String = UUID().uuidString
    
    var locations = List<Location>()
    
    // MARK: - Functions
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["date", "distance", "duration"]
    }
    
}

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
    
    convenience init(distance: Double, duration: Int, date: Date, locations: List<Location>) {
        self.init()
        self.distance = distance
        self.duration = duration
        self.date = date
        self.locations = locations
    }
    
    // MARK: - Properties
    
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var duration: Int = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var id: Int = 0
    var locations = List<Location>()
    
    // MARK: - Functions
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["date"]
    }
    
}

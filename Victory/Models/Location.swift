//
//  Location.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    
    // MARK: - Init
    
    convenience init(latitude: Double, longitude: Double, timestamp: Date, run: Run) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
        self.run = run
    }
    
    // MARK: - Properties
    
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var run: Run?
    @objc dynamic var id: Int = 0
    
    // MARK: - Functions
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["timestamp"]
    }
    
}

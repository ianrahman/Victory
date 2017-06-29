//
//  Run.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    
    // MARK: - Init
    convenience init(distance: Double, duration: Int, locations: List<Location>) {
        self.init()
        self.distance = distance
        self.duration = duration
        self.locations = locations
    }
    
    // MARK: - Persisted Properties
    
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var duration: Int = 0
    var locations = List<Location>()
    
    // MARK: - Computed Properties
    
    var date: Date {
        return locations.first?.timestamp ?? Date()
    }
    
    // MARK: - Functions
    
    override class func primaryKey() -> String? {
        return "date"
    }
    
}

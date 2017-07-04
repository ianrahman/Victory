//
//  Services.swift
//  Victory
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation
import CoreLocation

class Services {
    
    let data: DataService
    let location: LocationService
    
    public init() {
        self.data = DataService()
        self.location = LocationService()
    }
}

class DataService {
    
    var runs = [Run]()
    
}

class LocationService {
    
    static let manager = CLLocationManager()
    
}

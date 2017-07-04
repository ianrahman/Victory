//
//  Services.swift
//  Victory
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import CoreLocation

final class Services {
    
    let configuration = ConfigurationService()
    let data = DataService()
    let location = LocationService()
    
}

struct ConfigurationService {
    
    let tableViewRowHeight: CGFloat = 55
    
}

final class DataService {
    
    var runs = [Run]()
    
}

final class LocationService {
    
    static let manager = CLLocationManager()
    
}

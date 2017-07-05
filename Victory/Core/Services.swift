//
//  Services.swift
//  Victory
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

// MARK: - Services

final class Services {
    
    let configuration = ConfigurationService()
    let location = LocationService()
    let realm = try! Realm()
    
}

// MARK: - Configuration Services

struct ConfigurationService {
    
    let tableViewRowHeight: CGFloat = 55
    let titleFont = UIFont(name: "Helvetica Neue", size: 24)!
    let bodyFont = UIFont(name: "Helvetica Neue", size: 20)!
    let detailFont = UIFont(name: "Helvetica Neue", size: 16)!
    
}

// MARK: - Location Services

final class LocationService {
    
    let manager = CLLocationManager()
    
}

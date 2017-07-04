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

final class Services {
    
    let configuration = ConfigurationService()
    let data = DataService()
    let location = LocationService()
    
}

struct ConfigurationService {
    
    let tableViewRowHeight: CGFloat = 55
    let primaryColor = UIColor(red:0.84, green:0.00, blue:0.00, alpha:1.0)
    let secondaryColor = UIColor(red:0.61, green:0.00, blue:0.00, alpha:1.0)
    let textColor: UIColor = .white
    
}

final class DataService {
    
    var runs = [Run]()
    let realm = try! Realm()
    
}

final class LocationService {
    
    static let manager = CLLocationManager()
    
}

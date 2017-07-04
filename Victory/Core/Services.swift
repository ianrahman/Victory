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
    let victoryTitleFont = UIFont(name: "Helvetica Neue", size: 24)!
    let victoryBodyFont = UIFont(name: "Helvetica Neue", size: 20)!
    let victoryDetailFont = UIFont(name: "Helvetica Neue", size: 16)!
    
}

final class DataService {
    
    var runs = [Run]()
    let realm = try! Realm()
    
}

final class LocationService {
    
    static let manager = CLLocationManager()
    
}

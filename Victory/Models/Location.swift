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

    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var timestamp: Date = Date()
    dynamic var run = Run()
    
}

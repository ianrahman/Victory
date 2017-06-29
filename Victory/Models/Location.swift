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

    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var timestamp: Date = Date()
    @objc dynamic var run = Run()
    
}

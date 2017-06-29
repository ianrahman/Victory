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
    
    dynamic var distance: Double = 0.0
    dynamic var duration: Int = 0
    dynamic var startTime: Date = Date()
    dynamic var locations = List<Location>()
    
}

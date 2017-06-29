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
    convenience init(distance: Double) {
        self.init()
        self.distance = distance
    }
    
    // MARK: - Properties
    
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var duration: Int = 0
    @objc dynamic var startTime: Date = Date()
    let locations = List<Location>()
    
}

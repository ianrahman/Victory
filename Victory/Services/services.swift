//
//  Services.swift
//  ios-template
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import Foundation

struct Services {
    
    public let dataService: DataService
    
    public init() {
        self.dataService = DataService()
    }
}

struct Order {
    public let drinkType: String
    public let snackType: String
    
    public init(drinkType: String, snackType: String) {
        self.drinkType = drinkType
        self.snackType = snackType
    }
    
}

struct DataService {
    
    public var orders: [Order] = []
    
}

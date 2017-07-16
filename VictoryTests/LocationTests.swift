//
//  LocationTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class LocationTests: XCTestCase {
    
    func testLocationModel() {
        let testLatitude: Double = 1.0
        let testLongitude = 2.0
        let formatter = DateFormatter()
        let testRun = Run()
        
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        guard let testTimestamp = formatter.date(from: "1989/12/30 12:34:56") else { fatalError() }
        
        let location = Location()
        
        location.latitude = testLatitude
        location.longitude = testLongitude
        location.timestamp = testTimestamp
        location.run = testRun
        
        let latitude = location.latitude
        let longitude = location.longitude
        let timestamp = location.timestamp
        let run = location.run
        
        XCTAssertEqual(testLatitude, latitude, "Latitude property incorrect")
        XCTAssertEqual(testLongitude, longitude, "Longitude property incorrect")
        XCTAssertEqual(testTimestamp, timestamp, "Timestamp property incorrect")
        XCTAssertEqual(testRun, run, "Run property incorrect")
    }
    
}

//
//  LocationTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Victory

class LocationTests: XCTestCase {
    
    var testLatitude: Double!
    var testLongitude: Double!
    var testTimestamp: Date!
    var testRunObject: Run!
    var location: Location!
    
    override func setUp() {
        super.setUp()
        
        testLatitude = 1.0
        testLongitude = 2.0
        testRunObject = Run()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        testTimestamp = formatter.date(from: "1989/12/30 12:34:56")
        
        location = Location(latitude: testLatitude, longitude: testLongitude, timestamp: testTimestamp, run: testRunObject)
    }
    
    override func tearDown() {
        testLatitude = nil
        testLongitude = nil
        testTimestamp = nil
        testRunObject = nil
        location = nil
        
        super.tearDown()
    }
    
    func testLocationModel() {
        location.latitude = testLatitude
        location.longitude = testLongitude
        location.timestamp = testTimestamp
        location.run = testRunObject
        
        let latitude = location.latitude
        let longitude = location.longitude
        let timestamp = location.timestamp
        let run = location.run
        
        XCTAssertEqual(testLatitude, latitude, "Latitude property incorrect")
        XCTAssertEqual(testLongitude, longitude, "Longitude property incorrect")
        XCTAssertEqual(testTimestamp, timestamp, "Timestamp property incorrect")
        XCTAssertEqual(testRunObject, run, "Run property incorrect")
    }
    
}

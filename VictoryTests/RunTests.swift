//
//  RunTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Victory

class RunTests: XCTestCase {
    
    var testDistance: Int!
    var testDuration: Int!
    var testDate: Date!
    var testLocations: List<Location>!
    var run: Run!
    
    override func setUp() {
        super.setUp()
        
        testDistance = 1
        testDuration = 2
        
        let testLocation = Location()
        testLocations = List<Location>()
        testLocations.append(testLocation)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        testDate = formatter.date(from: "1989/12/30 12:34:56")
        
        run = Run(distance: testDistance, duration: testDuration, date: testDate, locations: testLocations)
    }
    
    override func tearDown() {
        testDistance = nil
        testDuration = nil
        testDate = nil
        testLocations = nil
        run = nil
        
        super.tearDown()
    }
    
    func testRunModel() {
        let distance = run.distance
        let duration = run.duration
        let date = run.date
        let location = run.locations.first
        
        XCTAssertEqual(distance, testDistance, "Distance property incorrect")
        XCTAssertEqual(duration, testDuration, "Duration property incorrect")
        XCTAssertEqual(date, testDate, "Date property incorrect")
        XCTAssertEqual(location, testLocations.first, "Locations property incorrect")
    }
    
}

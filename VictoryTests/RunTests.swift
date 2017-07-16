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
    
    func testRunModel() {
        let testDistance = 1
        let testDuration = 2
        let testLocation = Location()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        guard let testDate = formatter.date(from: "1989/12/30 12:34:56") else { fatalError() }
        
        let run = Run()
        run.distance = testDistance
        run.duration = testDuration
        run.date = testDate
        run.locations.append(testLocation)

        let distance = run.distance
        let duration = run.duration
        let date = run.date
        let location = run.locations.first
        
        XCTAssertEqual(distance, testDistance, "Distance property incorrect")
        XCTAssertEqual(duration, testDuration, "Duration property incorrect")
        XCTAssertEqual(date, testDate, "Date property incorrect")
        XCTAssertEqual(location, testLocation, "Locations property incorrect")
    }
    
}

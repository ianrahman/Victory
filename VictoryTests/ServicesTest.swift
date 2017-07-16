//
//  ServicesTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class ServicesTests: XCTestCase {
    
    var services: Services!
    
    override func setUp() {
        super.setUp()
        
        services = Services()
    }
    
    override func tearDown() {
        services = nil
        
        super.tearDown()
    }
    
    func testMeasurementFormatter() {
        let formatter = services.formatter
        let measurementFormatter = formatter.measurement
        
        let distance = Measurement<UnitLength>(value: Double(42.0), unit: UnitLength.miles)
        let formattedDistance = measurementFormatter.string(from: distance)
        
        XCTAssertEqual(formattedDistance, "42 mi", "Formatted distance is incorrect")
    }
    
    func testDateFormatter() {
        let formatter = services.formatter
        let dateFormatter = formatter.date
        let seconds = 42
        let timeInterval = TimeInterval(seconds)
        
        let formattedDate = dateFormatter.string(from: timeInterval)
        
        XCTAssertEqual(formattedDate, "0:00:42", "Formatted date is incorrect")
    }
    
    func testAvService() {
        let avService = services.av
        
        do {
            try avService.playTada()
        } catch let error {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
}

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
    var formatterService: FormatterService!
    var avService: AVService!
    
    override func setUp() {
        super.setUp()
        
        services = Services()
        formatterService = services.formatter
        avService = services.av
    }
    
    override func tearDown() {
        services = nil
        formatterService = nil
        avService = nil
        
        super.tearDown()
    }
    
    // MARK: - Formatter Service
    
    func testMeasurementFormatter() {
        let distance = Measurement<UnitLength>(value: Double(42.0), unit: UnitLength.miles)
        
        let formattedDistance = formatterService.formatted(measurement: distance)
        
        XCTAssertEqual(formattedDistance, "42 mi", "Formatted distance is incorrect")
    }
    
    
    func testDateFormatter() {
        let seconds = 42
        let timeInterval1 = TimeInterval(seconds)
        let timeInterval2 = TimeInterval()
        
        let formattedTime1 = formatterService.formatted(time: timeInterval1)
        let formattedTime2 = formatterService.formatted(time: timeInterval2)
        
        XCTAssertEqual(formattedTime1, "0:00:42", "Formatted date is incorrect")
        XCTAssertEqual(formattedTime2, "0:00:00", "Blank formatted date is incorrect")
    }
    
    // MARK: - AV Service
    
    func testAVServicePlaysSound() {
        do {
            try avService.playSound()
        } catch let error {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
    func testAVError() {
        let avAssetErrorDescription = "Asset not found."
        
        do {
            try avService.playSound("Error")
        } catch let error {
            XCTAssertEqual(error.localizedDescription, avAssetErrorDescription, "Failed to generate correct AV Error")
        }
    }
    
}

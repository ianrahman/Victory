//
//  FoundationExtensionsTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class FoundationExtensionsTests: XCTestCase {
    
    var date: Date!
    
    override func setUp() {
        super.setUp()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        date = formatter.date(from: "1989/12/30 12:34:56")
    }
    
    override func tearDown() {
        date = nil
        super.tearDown()
    }
    
    // MARK: - Date
    
    func testDateExtensions() {
        let year = 1989
        let month = 12
        let weekday = "Saturday"
        let monthAsString = "December"
        let day = 30
        let hour = 12
        let minute = 34
        let second = 56
        let prettyDate = "12/30/1989"
        let id = 19891230123456
        
        XCTAssert(date.year == year, "Year does not format correctly")
        XCTAssert(date.month == month, "Month does not format correctly")
        XCTAssert(date.weekday == weekday, "Weekday does not format correctly")
        XCTAssert(date.monthAsString == monthAsString, "Month as String does not format correctly")
        XCTAssert(date.day == day, "Day does not format correctly")
        XCTAssert(date.hour == hour, "Hour does not format correctly")
        XCTAssert(date.minute == minute, "Minute does not format correctly")
        XCTAssert(date.second == second, "Second does not format correctly")
        XCTAssert(date.prettyDate == prettyDate, "Pretty Date does not format correctly")
        XCTAssert(date.id == id, "ID does not format correctly")
    }
    
}

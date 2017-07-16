//
//  UIKitExtensionsTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class UIKitExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Storyboard
    
    func testStoryboardInstantiation() {
        for storyboard in iterateOverEnum(UIStoryboard.Storyboard.self) {
            do {
                let _ = try UIStoryboard(storyboard)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    private func iterateOverEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
  
    // MARK: - Color
    
    func testPerformanceColor() {
        let baseColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        let val0 = 0
        let val1 = 1
        let val2 = 2
        let val3 = 3
        let val4 = 4
        let low = 1
        let mid = 2
        let high = 3
        
        let uniformPerformanceColor = UIColor.performanceColor(value: val0, mid: mid, low: low, high: low)
        let lowPerformanceColor = UIColor.performanceColor(value: low, mid: mid, low: low, high: high)
        let midPerformanceColor = UIColor.performanceColor(value: mid, mid: mid, low: low, high: high)
        let highPerformanceColor = UIColor.performanceColor(value: high, mid: mid, low: low, high: high)
        let performanceColor0 = UIColor.performanceColor(value: val0, mid: mid, low: low, high: high)
        let performanceColor1 = UIColor.performanceColor(value: val1, mid: mid, low: low, high: high)
        let performanceColor2 = UIColor.performanceColor(value: val2, mid: mid, low: low, high: high)
        let performanceColor3 = UIColor.performanceColor(value: val3, mid: mid, low: low, high: high)
        let performanceColor4 = UIColor.performanceColor(value: val4, mid: mid, low: low, high: high)
        
        XCTAssert(uniformPerformanceColor == baseColor, "Failed to return base color for uniform speed")
        XCTAssert(performanceColor0 == baseColor, "Failed to return base color for value outside expected range")
        XCTAssert(performanceColor1 == lowPerformanceColor, "Failed to return low performance color for low value")
        XCTAssert(performanceColor2 == midPerformanceColor, "Failed to return mid performance color for mid value")
        XCTAssert(performanceColor3 == highPerformanceColor, "Failed to return high performance color for high value")
        XCTAssert(performanceColor4 == baseColor, "Failed to return base color for value outside expected range")
    }
    
}

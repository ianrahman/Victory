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
        
        let uniformPerformanceColor = UIColor.performanceColor(value: val0, low: low, mid: mid, high: low)
        let lowPerformanceColor = UIColor.performanceColor(value: low, low: low, mid: mid, high: high)
        let midPerformanceColor = UIColor.performanceColor(value: mid, low: low, mid: mid, high: high)
        let highPerformanceColor = UIColor.performanceColor(value: high, low: low, mid: mid, high: high)
        let performanceColor0 = UIColor.performanceColor(value: val0, low: low, mid: mid, high: high)
        let performanceColor1 = UIColor.performanceColor(value: val1, low: low, mid: mid, high: high)
        let performanceColor2 = UIColor.performanceColor(value: val2, low: low, mid: mid, high: high)
        let performanceColor3 = UIColor.performanceColor(value: val3, low: low, mid: mid, high: high)
        let performanceColor4 = UIColor.performanceColor(value: val4, low: low, mid: mid, high: high)
        
        XCTAssertEqual(uniformPerformanceColor, baseColor, "Failed to return base color for uniform speed")
        XCTAssertEqual(performanceColor0, baseColor, "Failed to return base color for value outside expected range")
        XCTAssertEqual(performanceColor1, lowPerformanceColor, "Failed to return low performance color for low value")
        XCTAssertEqual(performanceColor2, midPerformanceColor, "Failed to return mid performance color for mid value")
        XCTAssertEqual(performanceColor3, highPerformanceColor, "Failed to return high performance color for high value")
        XCTAssertEqual(performanceColor4, baseColor, "Failed to return base color for value outside expected range")
    }
    
}

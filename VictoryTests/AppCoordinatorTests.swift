//
//  AppCoordinatorTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class AppCoordinatorTests: XCTestCase {
    
    var appCoordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let services = Services()
        
        appCoordinator = AppCoordinator(window: window, services: services)
        appCoordinator.start()
    }
    
    override func tearDown() {
        appCoordinator = nil
        super.tearDown()
    }
    
    func testAppCoordinatorStart() {
        
        
        XCTAssertEqual("42 mi", "42 mi", "Formatted distance is incorrect")
    }
    
}

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
    
    func testAppCoordinator_SetsRootViewController() {
        let rootViewController = appCoordinator.rootViewController
        
        XCTAssert(rootViewController is UINavigationController, "Root view controller is incorrect type")
    }
    
    func testAppCoordinator_HasCorrectNumberOfInitialChildViewControllers() {
        let rootViewController = appCoordinator.rootViewController
        let childViewControllers = rootViewController.childViewControllers
        
        XCTAssertEqual(childViewControllers.count, 1, "Unexpected number of child view controllers")
    }
    
    func testAppCoordinator_HasCorrectInitialChildViewController() {
        let rootViewController = appCoordinator.rootViewController
        let childViewControllers = rootViewController.childViewControllers
        
        XCTAssert(childViewControllers.first is RunListViewController, "Child view controller is incorrect type")
    }
    
    func testAppCoordinator_SetsUILabelFont() {
        let labelFont = UILabel.appearance().font
        let bodyFont = appCoordinator.services.configuration.bodyFont
        
        XCTAssertEqual(labelFont, bodyFont, "Failed to set label font")
    }
    
}

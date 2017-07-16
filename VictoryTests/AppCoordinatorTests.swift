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
        let rootViewController = appCoordinator.rootViewController
        let appCoordinatorWindow = appCoordinator.window
        let childViewControllers = rootViewController.childViewControllers
        
        guard
            let appDelegate = UIApplication.shared.delegate,
            let appDelegateWindowOptional = appDelegate.window,
            let appDelegateWindow = appDelegateWindowOptional
            else { fatalError("Could not access app delegate's window") }

        XCTAssert(rootViewController is UINavigationController, "Root view controller is incorrect type")
        XCTAssertEqual(childViewControllers.count, 1, "Unexpected number of child view controllers")
        XCTAssert(childViewControllers.first is RunListViewController, "Child view controller is incorrect type")
//        XCTAssertEqual(appCoordinatorWindow, appDelegateWindow, "App coordinator window is incorrect")
    }
    
}

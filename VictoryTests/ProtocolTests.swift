//
//  ProtocolTests.swift
//  VictoryTests
//
//  Created by Ian Rahman on 7/16/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import XCTest
@testable import Victory

class ProtocolTests: XCTestCase {
    
    var window: UIWindow!
    var services: Services!
    var appCoordinator: Coordinator!
    
    override func setUp() {
        super.setUp()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        services = Services()
        
        appCoordinator = AppCoordinator(window: window, services: services)
        appCoordinator.start()
    }
    
    override func tearDown() {
        appCoordinator = nil
        services = nil
        window = nil
        
        super.tearDown()
    }
    
    // MARK: - Coordinator Protocol
    
    func testAddChildCoordinator() {
        let childCoordinator = AppCoordinator(window: window, services: services) as Coordinator
        
//        appCoordinator.addChildCoordinator(childCoordinator)
        
        XCTAssert(appCoordinator.childCoordinators.first === childCoordinator, "Failed to add child coordinator")
    }
    
    func testRemoveChildCoordinator() {
        
    }
    
}

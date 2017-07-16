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
        let childCoordinator1 = AppCoordinator(window: window, services: services) as Coordinator
        let childCoordinator2 = AppCoordinator(window: window, services: services) as Coordinator
        let childCoordinator3 = AppCoordinator(window: window, services: services) as Coordinator
        
        appCoordinator.addChildCoordinator(childCoordinator1)
        appCoordinator.addChildCoordinator(childCoordinator2)
        appCoordinator.addChildCoordinator(childCoordinator3)
        
        XCTAssert(appCoordinator.childCoordinators.count == 3, "Failed to add child coordinators")
        XCTAssert(appCoordinator.childCoordinators.first === childCoordinator1, "First child coordinator incorrect after adding child coordinators")
        XCTAssert(appCoordinator.childCoordinators.last === childCoordinator3, "Last child coordinator incorrect after adding child coordinators")
    }
    
    func testRemoveChildCoordinator() {
        let childCoordinator1 = AppCoordinator(window: window, services: services) as Coordinator
        let childCoordinator2 = AppCoordinator(window: window, services: services) as Coordinator
        let childCoordinator3 = AppCoordinator(window: window, services: services) as Coordinator
        
        appCoordinator.addChildCoordinator(childCoordinator1)
        appCoordinator.addChildCoordinator(childCoordinator2)
        appCoordinator.addChildCoordinator(childCoordinator3)
        
        guard let firstChild = appCoordinator.childCoordinators.first else { XCTFail("Failed to access first child coordinator"); return }
        appCoordinator.removeChildCoordinator(firstChild)
        XCTAssert(appCoordinator.childCoordinators.count == 2, "Failed to remove child coordinators")
        XCTAssert(appCoordinator.childCoordinators.first === childCoordinator2, "Wrong child coordinator removed")
    }
    
}

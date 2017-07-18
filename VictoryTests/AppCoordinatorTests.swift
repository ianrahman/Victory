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
    var services: Services!
    var run: Run!
    
    override func setUp() {
        super.setUp()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let serv = Services()
        
        appCoordinator = AppCoordinator(window: window, services: serv)
        appCoordinator.start()
        services = serv
        run = Run()
    }
    
    override func tearDown() {
        appCoordinator = nil
        services = nil
        run = nil
        
        super.tearDown()
    }
    
    func testAppCoordinator_SetsRootViewController() {
        let rootViewController = appCoordinator.rootViewController
        
        XCTAssert(rootViewController is UINavigationController, "Root view controller is incorrect type")
    }
    
    func testAppCoordinator_HasOneInitialChildViewControllers() {
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
        let bodyFont = services.configuration.bodyFont
        
        XCTAssertEqual(labelFont, bodyFont, "Failed to set label font")
    }
    
    func testAppCoordinator_DidTapNewRunButtonAddsOneChildCoordinator() {
        appCoordinator.didTapNewRunButton()
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1, "Failed to add correct number of child coordinators")
    }
    
    func testAppCoordinator_DidTapNewRunButtonAddsCorrectChildCoordinator() {
        appCoordinator.didTapNewRunButton()
        
        let firstChildCoordinator = appCoordinator.childCoordinators.first as? RunDetailCoordinator
        
        XCTAssertNotNil(firstChildCoordinator, "Failed to add correct child coordinator")
    }
    
    func testAppCoordinator_DidTapNewRunButtonPresentsChildRootViewController() {
        appCoordinator.didTapNewRunButton()
        
        let childNavigationController = appCoordinator.childCoordinators.first?.rootViewController as? UINavigationController
        let topViewController = childNavigationController?.childViewControllers.first as? RunDetailViewController
        
        XCTAssertNotNil(childNavigationController?.view, "Failed to load Run Detail navigation controller")
        XCTAssertNotNil(topViewController?.view, "Failed to load Run Detail view controller")
    }
    
    func testAppCoordinator_DidTapCloseButtonRemovesChildCoordinator() {
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: appCoordinator, type: .newRun)
        appCoordinator.addChildCoordinator(runDetailCoordinator)
        
        var childCoordinator = appCoordinator.childCoordinators.first
        
        XCTAssertNotNil(childCoordinator, "Failed to load child coordinator")
        
        appCoordinator.didTapCloseButton(runDetailCoordinator: runDetailCoordinator)
        
        childCoordinator = appCoordinator.childCoordinators.first
        
        XCTAssertNil(childCoordinator, "Failed to remove child coordinator")
    }
    
    func testAppCoordinator_DidSaveRunAddsRun() {
        let oldRuns: [Run] = Array(services.realm.objects(Run.self))
        let initialRunCount = oldRuns.count
        
        appCoordinator.didSaveRun(run)
        
        let newRuns: [Run] = Array(services.realm.objects(Run.self))
        let newRunCount = newRuns.count
        
        XCTAssert(initialRunCount == newRunCount - 1, "Failed to add run to realm")
        XCTAssert(newRuns.contains(run), "Failed to save new run")
        
        try! services.realm.write {
            services.realm.delete(run)
        }
    }
    
}

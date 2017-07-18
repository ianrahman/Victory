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
        let bodyFont = appCoordinator.services.configuration.bodyFont
        
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
    
    func testAppCoordinator_DidSaveRunAddsRun() {
        let runs: [Run] = Array(appCoordinator.services.realm.objects(Run.self).sorted(byKeyPath: "date")).reversed()
        let initialRunCount = runs.count
        let run = Run()
        
        appCoordinator.didSaveRun(run)
        let newRunCount = runs.count
        
        XCTAssert(initialRunCount == newRunCount - 1, "Failed to save new run")
    }
    
    func testAppCoordinator_RemovesRun() {
        let runs: [Run] = Array(appCoordinator.services.realm.objects(Run.self).sorted(byKeyPath: "date")).reversed()
        let tableView = UITableView()
        tableView.delegate = appCoordinator
        tableView.dataSource = appCoordinator
        tableView.reloadData()
        
        
    }
    
}

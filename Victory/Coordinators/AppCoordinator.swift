//
//  AppCoordinator.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - App Coordinator

final class AppCoordinator: NSObject, RootViewCoordinator {
    
    // MARK: - Properties
    
    let services: Services
    var childCoordinators: [Coordinator] = []
    
    private let runCellIdentifier = "runCell"
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    private lazy var runListViewController: RunListViewController = {
        let runListViewController = self.navigationController.viewControllers
            .filter({ $0.self is RunListViewController })
            .first as! RunListViewController
        return runListViewController
    }()
    
    // MARK: - Init
    
    public init(window: UIWindow, services: Services) {
        self.services = services
        self.window = window
    }
    
    // MARK: - Functions
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showInitialViewController()
    }
    
    /// Populate navigation controller with initial view controller
    private func showInitialViewController() {
        let storyboard = UIStoryboard(.RunList)
        let viewController: RunListViewController = storyboard.instantiateViewController()
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }
    
    private func setGeneralAppearance() {
        UILabel.appearance().font = services.configuration.bodyFont
    }
    
}

// MARK: - Run List View Controller Delegate

extension AppCoordinator: RunListCoordinator {
    
    func viewDidLoad(_ viewController: RunListViewController) {
        viewController.tableView.delegate = self
        viewController.tableView.dataSource = self
        setUI(for: viewController)
    }
    
    func didTapNewRunButton() {
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .newRun)
        startAndPresent(runDetailCoordinator)
    }
    
    private func startAndPresent(_ runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.start()
        addChildCoordinator(runDetailCoordinator)
        rootViewController.present(runDetailCoordinator.rootViewController, animated: true)
    }
    
    private func reloadData() {
        runListViewController.tableView.reloadData()
    }
    
    private func setUI(for viewController: RunListViewController) {
        viewController.title = "Victory"
        viewController.navigationItem.rightBarButtonItem = viewController.newRunBarButtonItem
        viewController.tableView.rowHeight = services.configuration.tableViewRowHeight
    }
}

// MARK: - TableView Delegate

extension AppCoordinator: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let run = services.realm.objects(Run.self)[indexPath.row]
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .previousRun(run: run))
        startAndPresent(runDetailCoordinator)
    }
    
}

// MARK: - TableView Data Source

extension AppCoordinator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let runs = services.realm.objects(Run.self)
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let runs = services.realm.objects(Run.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.text = "\(runs[indexPath.row].date.pretty)"
        cell.detailTextLabel?.text = "\(runs[indexPath.row].distance) miles"
        return cell
    }
    
}

// MARK: - Run Detail Coordinator Delegate

extension AppCoordinator: RunDetailCoordinatorDelegate {
    
    func didTapCloseButton(runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.rootViewController.dismiss(animated: true)
        removeChildCoordinator(runDetailCoordinator)
        reloadData()
    }
    
}

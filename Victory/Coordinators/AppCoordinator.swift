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
    private let window: UIWindow
    private let runCellIdentifier = "runCell"
    
    private var runs: [Run] {
        return Array(services.realm.objects(Run.self).sorted(byKeyPath: "date")).reversed()
    }
    
    private var distanceRange: (low: Int, mid: Int, high: Int) {
        let runs = services.realm.objects(Run.self).sorted(byKeyPath: "distance")
        let low = runs.first?.distance ?? 0
        let high = runs.last?.distance ?? 0
        let mid = (low + high) / 2
        return (low, mid, high)
    }
    
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
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
        setGeneralAppearance()
    }
    
    /// Populate navigation controller with initial view controller
    private func showInitialViewController() {
        if let storyboard = try? UIStoryboard(.RunList),
            let viewController: RunListViewController = try? storyboard.instantiateViewController() {
            viewController.coordinator = self
            navigationController.viewControllers = [viewController]
        }
    }
    
    private func setGeneralAppearance() {
        UILabel.appearance().font = services.configuration.bodyFont
    }
    
    private func removeRun(for tableView: UITableView, at indexPath: IndexPath) {
        let runToDelete = runs[indexPath.row]
        try! services.realm.write {
            services.realm.delete(runToDelete)
        }
        reloadData(for: tableView)
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
    
    private func reloadData(for tableView: UITableView) {
        tableView.reloadData()
    }
    
    private func setUI(for viewController: RunListViewController) {
        viewController.title = "Victory"
        viewController.navigationItem.rightBarButtonItem = viewController.newRunBarButtonItem
        viewController.tableView.rowHeight = services.configuration.tableViewRowHeight
        viewController.tableView.separatorInset = .zero
    }
    
}

// MARK: - TableView Delegate

extension AppCoordinator: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let run = runs[indexPath.row]
        let runDetailCoordinator = RunDetailCoordinator(with: services, delegate: self, type: .previousRun(run: run))
        startAndPresent(runDetailCoordinator)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            removeRun(for: tableView, at: indexPath)
        default:
            break
        }
    }
}

// MARK: - TableView Data Source

extension AppCoordinator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let run = runs[indexPath.row]
        let distance = Measurement<UnitLength>(value: Double(run.distance), unit: UnitLength.meters)
        let formattedDistanceString = services.formatter.formatted(measurement: distance)
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(run.date.prettyDate)"
        cell.detailTextLabel?.text = "\(formattedDistanceString)"
        cell.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        
        return cell
    }
    
}

// MARK: - Run Detail Coordinator Delegate

extension AppCoordinator: RunDetailCoordinatorDelegate {
    
    func didTapCloseButton(runDetailCoordinator: RunDetailCoordinator) {
        runDetailCoordinator.rootViewController.dismiss(animated: true)
        removeChildCoordinator(runDetailCoordinator)
    }
    
}

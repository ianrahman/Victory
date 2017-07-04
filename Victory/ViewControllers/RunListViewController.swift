//
//  RunListViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol RunListCoordinator: Coordinator {
    
    func didTapNewRunButton()
    func didSelectRowAt(indexPath: IndexPath)
    
}

final class RunListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    let runCellIdentifier = "runCell"
    
    weak var coordinator: RunListCoordinator?
    
    lazy var newRunBarButtonItem: UIBarButtonItem = {
        let newRunBarButtonItem = UIBarButtonItem(title: "New Run", style: .plain, target: self, action: #selector(didTapNewRunButton))
        return newRunBarButtonItem
    }()
    
    // MARK: - Actions
    
    @objc private func didTapNewRunButton() {
        coordinator?.didTapNewRunButton()
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setUI()
    }
    
    private func setUI() {
        title = "Victory"
        navigationItem.rightBarButtonItem = newRunBarButtonItem
        tableView.rowHeight = coordinator?.services.configuration.tableViewRowHeight ?? 0
    }
    
}

// MARK: - TableView Delegate
    
extension RunListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didSelectRowAt(indexPath: indexPath)
    }
    
}

// MARK: - TableView Data Source

extension RunListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator?.services.data.runs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coordinator = coordinator else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.8399999738, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.text = "\(coordinator.services.data.runs[indexPath.row].date.pretty)"
        cell.detailTextLabel?.text = "\(coordinator.services.data.runs[indexPath.row].distance) miles"
        return cell
    }
    
}

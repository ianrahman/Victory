//
//  RunListViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

protocol RunListViewControllerDelegate: class {
    
    func didTapNewRunButton()
    func didSelectRowAt(indexPath: IndexPath)
    
}

final class RunListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: RunListCoordinator?
    
    let runCellIdentifier = "runCell"
    
    @IBAction func didTapAddButton(_ sender: Any) {
        coordinator?.didTapNewRunButton()
    }
    
    lazy var newRunBarButtonItem: UIBarButtonItem = {
        let newRunBarButtonItem = UIBarButtonItem(title: "New Run", style: .plain, target: self, action: #selector(didTapNewRunButton))
        return newRunBarButtonItem
    }()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = newRunBarButtonItem
    }
    
    @objc private func didTapNewRunButton() {
        coordinator?.didTapNewRunButton()
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
        guard let coordinator = coordinator else { return 0 }
        return coordinator.services.data.runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coordinator = coordinator else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(coordinator.services.data.runs[indexPath.row].date)"
        cell.detailTextLabel?.text = "\(coordinator.services.data.runs[indexPath.row].distance) miles"
        return cell
    }
    
}


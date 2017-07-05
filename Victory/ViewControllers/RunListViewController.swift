//
//  RunListViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

// MARK: - Run List Coordinator

protocol RunListCoordinator: Coordinator {
    
    func viewDidLoad(_ viewController: RunListViewController)
    func didTapNewRunButton()
    
}

// MARK: - Run List View Controller

final class RunListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
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
        coordinator?.viewDidLoad(self)
    }
    
}

//
//  RunListViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import RealmSwift

class RunListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    let runCellIdentifier = "runCell"
    let locationManager = CLLocationManager()
    let realm = try! Realm()
    let runs = [Run]()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    
}

// MARK: - TableView Delegate

extension RunListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let runs = realm.objects(Run.self).sorted(byKeyPath: "date")
//        let run = runs(indexPath.row)
//        let runDetailVC = RunDetailViewController(run: run)
//        present
    }
    
}

// MARK: - TableView Data Source

extension RunListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return realm.objects(Run.self).count
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        cell.detailTextLabel?.text = "devil"
        return cell
    }
    
}

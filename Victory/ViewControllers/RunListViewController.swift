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
    
    let services: Services
    weak var delegate: ViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    let runCellIdentifier = "runCell"
    let realm = try! Realm()
    let runs = [Run]()
    
    // MARK: - Init
    
    init(services: Services, delegate: ViewControllerDelegate) {
        self.services = services
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Runs"
        
        print("hi i guess run list should be loaded")
        
    }
    
}

// MARK: - TableView Delegate
    
extension RunListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let run = runs[indexPath.row]
        let storyboard = UIStoryboard(.RunDetail)
        let vc: RunDetailViewController = storyboard.instantiateViewController()
        vc.run = run
        present(vc, animated: true)
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


//
//  RunListViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/28/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import RealmSwift

final class RunListViewController: UIViewController {
    
    // MARK: - Properties
    
    let services: Services
    weak var delegate: ViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    let runCellIdentifier = "runCell"
    let realm = try! Realm()
    
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
        let run = services.data.runs[indexPath.row]
        let storyboard = UIStoryboard(.RunDetail)
        let vc: RunDetailViewController = storyboard.instantiateViewController()
        vc.layout(for: run)
        present(vc, animated: true)
    }
    
}

// MARK: - TableView Data Source

extension RunListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.data.runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: runCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(services.data.runs[indexPath.row].date)"
        cell.detailTextLabel?.text = "\(services.data.runs[indexPath.row].distance) miles"
        return cell
    }
    
}


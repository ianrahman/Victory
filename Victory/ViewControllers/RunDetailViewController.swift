//
//  RunDetailViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/29/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

class RunDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var run: Run!
    
    // MARK: - Init
    
    init(run: Run) {
        super.init(nibName: "RunDetail", bundle: nil)
        self.run = run
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        
    }
    
}


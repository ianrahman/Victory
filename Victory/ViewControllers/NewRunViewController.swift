//
//  NewRunViewController.swift
//  Victory
//
//  Created by Ian Rahman on 6/30/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit

final class NewRunViewController: UIViewController {
    
    internal let services: Services
    
    weak var delegate: ViewControllerDelegate?
    
    init(services: Services, delegate: ViewControllerDelegate) {
        self.services = services
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }
    
    private func updateView() {
        
    }
    
}

extension NewRunViewController: ViewControllerProtocol { }


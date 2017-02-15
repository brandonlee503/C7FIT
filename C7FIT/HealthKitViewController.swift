//
//  HealthKitViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class HealthKitViewController: UIViewController {
    
    // MARK: - Properties
    
    var healthView = HealthKit()
    var healthKitManager = HealthKitManager()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Health"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        healthView.authButton.addTarget(self, action: #selector(authorizeHealthKit), for: .touchUpInside)
        
        self.view.addSubview(healthView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        healthView.translatesAutoresizingMaskIntoConstraints = false
        let topView = healthView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = healthView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = healthView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = healthView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    func authorizeHealthKit() {
        print("authorizing health kit")
        // FIXME: build error/success handling into manager
        healthKitManager.authorizeHealthKit()
    }

}

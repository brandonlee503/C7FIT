//
//  ActivityViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    // MARK: - Properties
    
    var activityView = ActivityView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Activity"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.view.addSubview(activityView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        let topView = activityView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = activityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = activityView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = activityView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
}

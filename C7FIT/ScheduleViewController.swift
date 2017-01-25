//
//  ScheduleViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    // MARK: - Properties
    
    var scheduleView = ScheduleView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schedule"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.view.addSubview(scheduleView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {        
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        let topView = scheduleView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = scheduleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = scheduleView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = scheduleView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
}

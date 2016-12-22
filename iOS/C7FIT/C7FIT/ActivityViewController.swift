//
//  ActivityViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    var activityView = ActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Activity"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 98/255, green: 65/255, blue: 133/255, alpha: 1)
        
        self.view.addSubview(activityView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        let centerViewX = activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerViewY = activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([centerViewX, centerViewY])
    }
}

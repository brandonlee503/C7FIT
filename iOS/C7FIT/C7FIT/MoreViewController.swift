//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 98/255, green: 65/255, blue: 133/255, alpha: 1)
        
        self.view.addSubview(profileView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        let centerViewX = profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerViewY = profileView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([centerViewX, centerViewY])
    }
}

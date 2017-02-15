//
//  WatchViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class WatchViewController: UIViewController {

    
    // MARK: - Properties
    
    var watchView = WatchView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Watch"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.view.addSubview(watchView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        watchView.translatesAutoresizingMaskIntoConstraints = false
        let topView = watchView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = watchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = watchView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = watchView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

}

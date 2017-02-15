//
//  CountViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class CountViewController: UIViewController {

    
    // MARK: - Properties
    
    var countView = CountView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Count"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.view.addSubview(countView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        countView.translatesAutoresizingMaskIntoConstraints = false
        let topView = countView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = countView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = countView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = countView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

}

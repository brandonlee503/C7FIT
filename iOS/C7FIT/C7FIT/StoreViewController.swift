//
//  StoreViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    var storeView = StoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 98/255, green: 65/255, blue: 133/255, alpha: 1)
        
        self.view.addSubview(storeView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        storeView.translatesAutoresizingMaskIntoConstraints = false
        let topView = storeView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = storeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = storeView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = storeView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
}

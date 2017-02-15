//
//  MapViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    
    // MARK: - Properties
    
    var mapView = MapView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.view.addSubview(mapView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let topView = mapView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = mapView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

}

//
//  MapCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UITableViewCell {
    
    // MARK: - Properties
    
    var mapView: MKMapView = MKMapView()

    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func setup() {
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        addSubview(mapView)
        
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let mapLeft = mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        let mapTop = mapView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let mapRight = mapView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        let mapBottom = mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([mapLeft, mapTop, mapRight, mapBottom])
    }

}

//
//  Map.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate {
    // MARK: - Properties
    
    var titleLabel: UILabel = UILabel()
    var mapView: MKMapView = MKMapView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    
    
    func setup() {
        //title
//        titleLabel.text = "Map Stuff"
//        addSubview(titleLabel)
        
        //mapview
        
//        let leftMargin:CGFloat = 10
//        let topMargin:CGFloat = 60
//        let mapWidth:CGFloat = view.frame.size.width-20
//        let mapHeight:CGFloat = 300
        
//        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
//        mapView.center = view.center
        
        addSubview(mapView)
    }
    
    func setupConstraints() {
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        let centerTitleX = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
//        let centerTitleY = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
//        NSLayoutConstraint.activate([centerTitleX, centerTitleY])
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let mapHeight = mapView.heightAnchor.constraint(equalToConstant: 500)
//        let mapWidth = mapView.widthAnchor.constraint(equalToConstant: 300)
        let mapLeftMargin = mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
//        let mapTopMargin = mapView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let mapBottom = mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        let mapTrailingMargin = mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([mapHeight,mapTrailingMargin,mapBottom,mapLeftMargin])
        
    }

}

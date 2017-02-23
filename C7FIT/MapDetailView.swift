//
//  MapDetailView.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapDetailView: UIView {
    
    // MARK: - Properties
    
    var mapView: MKMapView = MKMapView()
    
    var secondsQuantity: UILabel = UILabel()
    var distanceQuantity: UILabel = UILabel()
    var paceQuantity: UILabel = UILabel()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setup() {
        
        secondsQuantity.text = "Seconds: "
        addSubview(secondsQuantity)
        
        distanceQuantity.text = "Distance: "
        addSubview(distanceQuantity)
        
        paceQuantity.text = "Pace: "
        addSubview(paceQuantity)
        //mapview
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        addSubview(mapView)
        
    }
    
    func setupConstraints() {
        
        distanceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let distanceLead = distanceQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let distanceTop = distanceQuantity.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        NSLayoutConstraint.activate([distanceLead, distanceTop])
        
        secondsQuantity.translatesAutoresizingMaskIntoConstraints = false
        let secondsLead = secondsQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let secondsTop = secondsQuantity.topAnchor.constraint(equalTo: distanceQuantity.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([secondsLead, secondsTop])
        
        paceQuantity.translatesAutoresizingMaskIntoConstraints = false
        let paceLead = paceQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let paceTop = paceQuantity.topAnchor.constraint(equalTo: secondsQuantity.bottomAnchor, constant: 10)
        NSLayoutConstraint.activate([paceLead, paceTop])
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let mapLeftMargin = mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let mapTopMargin = mapView.topAnchor.constraint(equalTo: paceQuantity.bottomAnchor, constant: 10)
        let mapBottom = mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        let mapTrailingMargin = mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([mapTopMargin,mapTrailingMargin,mapBottom,mapLeftMargin])
    }

}

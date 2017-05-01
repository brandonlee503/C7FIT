//
//  RunListTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 3/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit

class RunListCell: UITableViewCell {

    // MARK: - Properties

    var titleLabel = UILabel()
    var valLabel = UILabel()
    var mapView = MKMapView()

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
        addSubview(titleLabel)

        addSubview(valLabel)

        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.showsUserLocation = false

        addSubview(mapView)
    }

    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let mapLeft = mapView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let mapRight = mapView.rightAnchor.constraint(equalTo: mapView.leftAnchor, constant: 100)
        let mapTop = mapView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let mapBottom = mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([mapLeft, mapRight, mapTop, mapBottom])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = titleLabel.leftAnchor.constraint(equalTo: mapView.rightAnchor, constant: 10)
        let titleTop = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        NSLayoutConstraint.activate([titleLead, titleTop])

        valLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLeft = valLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        let dateTop = valLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        NSLayoutConstraint.activate([dateLeft, dateTop])
    }
}

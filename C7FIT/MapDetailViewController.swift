//
//  MapDetailViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

//
//  MapDetailViewViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import HealthKit
import MapKit

class MapDetailViewController: UIViewController {
    
    var mapView = MapDetailView()
    var currentRun: RunData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(mapView)
        loadMap()
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let topView = mapView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = mapView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    // MARK: - Init
    
    init(run: RunData) {
        self.currentRun = run
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func mapRegion() -> MKCoordinateRegion {
        let initialLoc = currentRun.locations[1]
        
        var minLat = initialLoc.latitude
        var minLng = initialLoc.longitude
        var maxLat = minLat
        var maxLng = minLng
        
        let locations = currentRun.locations
        
        for location in locations {
//            print(location.latitude)
//            print(location.longitude)
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLng, location.longitude)
        }
        
//        print("minLat \(minLat)")
//        print("minLng \(minLng)")
//        print("maxLat \(maxLat)")
//        print("maxLng \(maxLng)")
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
                                           longitude: (minLng + maxLng)/2),
            span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.1,
                                   longitudeDelta: (maxLng - minLng)*1.1))
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKind(of: MKPolyline.self) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 3
        return renderer
    }
    
    func polyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        
        let locations = currentRun.locations
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude,
                                                 longitude: location.longitude))
        }
        
        return MKPolyline(coordinates: &coords, count: currentRun.locations.count)
    }
    
    func loadMap() {
        if currentRun.locations.count > 0 {
            print("loading map")
            mapView.mapView.isHidden = false
            
            // Set the map bounds
            mapView.mapView.region = mapRegion()
            
            // Make the line(s!) on the map
            mapView.mapView.add(polyline())
        } else {
            // No locations were found!
            mapView.mapView.isHidden = true
            
//            UIAlertView(title: "Error",
//                        message: "Sorry, this run has no locations saved",
//                        delegate:nil,
//                        cancelButtonTitle: "OK").show()
        }
    }
    
    
    
}

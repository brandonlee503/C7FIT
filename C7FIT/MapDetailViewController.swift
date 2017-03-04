//
//  MapDetailViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/23/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//


import UIKit
import HealthKit
import MapKit

class MapDetailViewController: UIViewController, MKMapViewDelegate {
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    
    
    var userID: String?
    var mapView = MapDetailView()
    var currentRun: RunData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        self.edgesForExtendedLayout = []
        mapView.mapView.showsUserLocation = true
        self.mapView.mapView.delegate = self
        
        
        
        self.view.addSubview(mapView)
        
        
        if(loadMap()) {
            self.mapView.saveButton.addTarget(self, action: #selector(saveRun), for: .touchUpInside)
        } else {
            self.mapView.saveButton.addTarget(self, action: #selector(cantSaveRun), for: .touchUpInside)
        }

        //what data display for run?
        
        //save run
        
        //mile breakdown?
        
        
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
        let initialLoc = currentRun.locations[0]
        
        var minLat = initialLoc.latitude
        var minLng = initialLoc.longitude
        var maxLat = minLat
        var maxLng = minLng
        
        let locations = currentRun.locations
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLng, location.longitude)
        }
        
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLng + maxLng)/2),
            //change span doesnt work for long runs
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 4.0
        return renderer
    }
    
    //draw line from coordinates
    func polyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        
        print("polyline")
        let locations = currentRun.locations
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude,
                                                 longitude: location.longitude))
        }
        print(coords)
        return MKPolyline(coordinates: &coords, count: currentRun.locations.count)
    }
    
    func loadMap() -> Bool {
        if currentRun.locations.count > 0 {
            print("loading map")
            mapView.mapView.isHidden = false
            
            mapView.mapView.region = mapRegion()
            print("region done")
            
            mapView.mapView.add(polyline(), level: MKOverlayLevel.aboveRoads)
            print("line added")
            return true
        } else {
            // No locations were found!
//            mapView.mapView.isHidden = true
        
//            UIAlertView(title: "Error",
//                        message: "Sorry, this run has no locations saved",
//                        delegate:nil,
//                        cancelButtonTitle: "OK").show()
            return false
        }
    }
    
    func saveRun() {
        firebaseDataManager.monitorLoginState() { auth, user in
            guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion: nil) }
            self.userID = userID
            print("state change, new Run: \(self.currentRun.runTitle)")
            self.firebaseDataManager.updateUserRun(uid: userID, runTitle:self.currentRun.runTitle, userRun: self.currentRun)
        }
    }
    
    func cantSaveRun() {
        let alert = UIAlertController(title: "Location Data Error", message: "This run couldn't be saved sorry", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

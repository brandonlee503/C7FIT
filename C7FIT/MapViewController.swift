//
//  MapViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit
import HealthKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{

    
    // MARK: - Properties
    
    var mapViewApp = MapView()
    lazy var locationManager = CLLocationManager()
    var seconds = 0.0
    var distance = 0.0
    var pace = ""
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    
    var lastRun = RunData()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        self.edgesForExtendedLayout = []
        
        mapViewApp.startButton.addTarget(self, action: #selector(startTrackRun), for: .touchUpInside)
        mapViewApp.stopButton.addTarget(self, action: #selector(stopTrackRun), for: .touchUpInside)
        mapViewApp.stopButton.isEnabled = false
        mapViewApp.mapView.showsUserLocation = true
        
        self.view.addSubview(mapViewApp)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
        
        
//        setupLocationTracking()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        mapViewApp.translatesAutoresizingMaskIntoConstraints = false
        let topView = mapViewApp.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = mapViewApp.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = mapViewApp.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = mapViewApp.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    // MARK: - Tracking run
    
    // MARK: Start/Stop Buttons
    func startTrackRun(){
        if(!CLLocationManager.locationServicesEnabled()) {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please allow C7Fit to use your location to track your run", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return;
        }
        
        mapViewApp.stopButton.isEnabled = true
        mapViewApp.startButton.isEnabled = false
        
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(eachSecond), userInfo: nil, repeats: true)
        setupLocationTracking()
    }
    
    func stopTrackRun(){
        mapViewApp.startButton.isEnabled = true
        mapViewApp.stopButton.isEnabled = false
        
        //open up run in detail view here
        //ask user if they want to save run
        createRunData()
        self.navigationController?.pushViewController(MapDetailViewController(run:lastRun), animated: true)
        timer.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: Create Run Data
    func createRunData() {
        var tempRun = RunData()
        var savedLocations = [Location]()
        
        print(savedLocations)
        var i = 0
        for location in locations {
            var tempLocation = Location()
            tempLocation.timestamp = location.timestamp.description
            tempLocation.latitude = location.coordinate.latitude
            tempLocation.longitude = location.coordinate.longitude
            savedLocations.append(tempLocation)
            i = i + 1
        }
        tempRun.distance = distance
        tempRun.time = seconds
        tempRun.pace = pace
        tempRun.locations = savedLocations
        lastRun = tempRun
    }
    
    // MARK: location tracking
    func setupLocationTracking() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 5
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            //Focus on the runner
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapViewApp.mapView.setRegion(region, animated: true)
            
            if location.horizontalAccuracy < 50 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                }
                self.locations.append(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    // MARK: Timer
    func eachSecond(timer: Timer) {
        seconds = seconds + 1
//        let totalTimeQuantity = seconds
        let minuteQuantity = HKQuantity(unit: HKUnit.minute(), doubleValue: floor(seconds/60))
        let secondsQuantity = HKQuantity(unit: HKUnit.second(), doubleValue: seconds.truncatingRemainder(dividingBy: 60.0))
        mapViewApp.secondsQuantity.text = "Time Elapsed: " + minuteQuantity.description + " " + secondsQuantity.description
        
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        mapViewApp.distanceQuantity.text = "Distance: " + distanceQuantity.description
        
    // convert to mile per minute
        let paceUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: distance / seconds)
        mapViewApp.paceQuantity.text = "Pace: " + paceQuantity.description
        pace = paceQuantity.description
    }

}

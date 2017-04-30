//
//  MapTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit
import HealthKit
import CoreLocation

class MapTableViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: - Identifiers

    let mapCellID = "mapCell"
    let startStopID = "startStopCell"
    let timerCellID = "timerCell"

    // MARK: - Properties

    var seconds = 0.0
    var distance = 0.0
    var pace = ""
    lazy var locationManager = CLLocationManager()
    lazy var locations = [CLLocation]()
    lazy var timer = Timer()
    var lastRun = RunData()
    var currentPath = [CLLocationCoordinate2D]()

    let startStopCell = StartStopCell()
    let mapCell = MapCell()
    let timerCell = TimerCell()

    // MARK: - Table View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapCell.self, forCellReuseIdentifier: mapCellID)
        tableView.register(StartStopCell.self, forCellReuseIdentifier: startStopID)
        tableView.register(TimerCell.self, forCellReuseIdentifier: timerCellID)
        setup()
    }

    // Setup the cells
    func setup() {
        // Old run button
        let oldRunButton = UIBarButtonItem(title: "Old Runs", style: .plain, target: self, action: #selector(gotoRunList))
        navigationItem.rightBarButtonItem = oldRunButton

        // Cell buttons
        startStopCell.startButton.addTarget(self, action: #selector(startTrackRun), for: .touchUpInside)
        startStopCell.stopButton.addTarget(self, action: #selector(stopTrackRun), for: .touchUpInside)
        colorSwitch(startEnabled: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row  == 0 {
            let cell = self.timerCell
            return cell
        } else if indexPath.row == 1 {
            let cell = self.mapCell
            self.mapCell.mapView.delegate = self
            return cell
        } else if indexPath.row == 2 {
            let cell = self.startStopCell
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: find a better way to calc viewable screen size
        let screenSize: CGRect = UIScreen.main.bounds
        let navBarSize: CGFloat? = self.navigationController?.navigationBar.frame.size.height
        let tabBarSize: CGFloat? = self.tabBarController?.tabBar.frame.size.height
        let statusBarSize: CGFloat? = UIApplication.shared.statusBarFrame.height
        let barConstants = screenSize.height - (navBarSize! + tabBarSize! + statusBarSize!)
        let cellHeight: CGFloat = 40.0

        if indexPath.row == 0 || indexPath.row == 2 {
           return cellHeight * 2
        } else if indexPath.row == 1 {
           return barConstants - (cellHeight * 4)
        }
        return cellHeight
    }

    // MARK: Start/Stop Buttons

    func startTrackRun() {
        // Check location services
        if !CLLocationManager.locationServicesEnabled() {
            let alert = UIAlertController(title: "Location Services Disabled",
                                          message: "Please allow C7Fit to use your location to track your run",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        // Stop user invalid input
        colorSwitch(startEnabled: 0)

        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(eachSecond), userInfo: nil, repeats: true)
        setupLocationTracking()

        self.tableView.reloadData()
    }

    func stopTrackRun() {
        // Stop user from invalid input
        colorSwitch(startEnabled: 1)
        self.tableView.reloadData()
        // Create runData struct from run data and push to map detail view
        createRunData()
        // Remove timer
        timer.invalidate()
        // Stop tracking user
        locationManager.stopUpdatingLocation()
        self.navigationController?.pushViewController(MapDetailTableViewController(run:lastRun, hideSave:false), animated: true)
    }

    func gotoRunList() {
        self.navigationController?.pushViewController(RunListTableViewController(), animated: true)
    }

    // MARK: location tracking

    func setupLocationTracking() {
        // Start tracking location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 2
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            // Focus on the runner
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.mapCell.mapView.setRegion(region, animated: true)

            // Dont record location if accuracy too low
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                }
                self.locations.append(location)
                self.currentPath.append(CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                               longitude: location.coordinate.longitude))

                if seconds > 3 {
                    self.mapCell.mapView.add(polyline(coords: self.currentPath), level: MKOverlayLevel.aboveRoads)
                }
            } else {
                print("loc accuracy too low")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

    // MARK: Timer

    func eachSecond(timer: Timer) {
        // Total time for the run
        seconds += 1
        timerCell.timeLabel.text = RunData.dispTimePrettyColon(time: seconds)
        let secondsHK = HKQuantity(unit: HKUnit.second(), doubleValue: seconds)
        let distanceHK = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        print(secondsHK.description)
        print(distanceHK.description)

        // Calculate the pace
        let paceUnit = HKUnit.minute().unitDivided(by: HKUnit.mile())
        let paceVal = secondsHK.doubleValue(for: HKUnit.minute()) / distanceHK.doubleValue(for: HKUnit.mile())
        let roundedPace = RunData.roundDouble(double: paceVal, round: 2)
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: roundedPace)
        pace = paceQuantity.description
    }

    // MARK: - Create Run Data

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
            i += 1
        }
        tempRun.distance = RunData.roundDouble(double: distance, round: 2)
        tempRun.time = seconds
        tempRun.pace = pace
        tempRun.locations = savedLocations
        tempRun.date = Date()
        tempRun.runTitle = "Today's Run"
        lastRun = tempRun
    }

    // MARK: - Display run line
    // Renderer for the line overlay, determines how the run line will look
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 6.0
        return renderer
    }

    // Draw line from coordinates
    func polyline(coords: [CLLocationCoordinate2D]) -> MKPolyline {
        return MKPolyline(coordinates: coords, count: coords.count)
    }

    func colorSwitch(startEnabled: Int) {
        if startEnabled == 1 {
            self.startStopCell.startButton.setTitleColor(.white, for: .normal)
            self.startStopCell.startButton.backgroundColor = .orange
            self.startStopCell.startButton.isUserInteractionEnabled = true

            self.startStopCell.stopButton.setTitleColor(.orange, for: .normal)
            self.startStopCell.stopButton.backgroundColor = .white
            self.startStopCell.stopButton.isUserInteractionEnabled = false
        } else {
            self.startStopCell.startButton.setTitleColor(.orange, for: .normal)
            self.startStopCell.startButton.backgroundColor = .white
            self.startStopCell.startButton.isUserInteractionEnabled = false

            self.startStopCell.stopButton.setTitleColor(.white, for: .normal)
            self.startStopCell.stopButton.backgroundColor = .orange
            self.startStopCell.stopButton.isUserInteractionEnabled = true
        }
    }

}

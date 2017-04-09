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

    let startStopCell = StartStopCell()
    let mapCell = MapCell()
    let timerCell = TimerCell()

    // MARK: - Table View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

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
        navigationItem.rightBarButtonItem?.tintColor = .black

        // Cell buttons
        startStopCell.startButton.addTarget(self, action: #selector(startTrackRun), for: .touchUpInside)
        startStopCell.stopButton.addTarget(self, action: #selector(stopTrackRun), for: .touchUpInside)
        startStopCell.startButton.isEnabled = true
        startStopCell.stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            let cell = self.startStopCell
            return cell
        } else if indexPath.row == 1 {
            let cell = self.timerCell
            return cell
        } else if indexPath.row == 2 {
            let cell = self.mapCell
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

        if indexPath.row == 1 {
           return cellHeight * 2
        } else if indexPath.row == 2 {
           return barConstants - (cellHeight * 3)
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
        self.startStopCell.stopButton.isEnabled = true
        self.startStopCell.startButton.isEnabled = true

        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepingCapacity: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(eachSecond), userInfo: nil, repeats: true)
        setupLocationTracking()

        self.tableView.reloadData()
    }

    func stopTrackRun() {
        // Stop user from invalid input
        self.startStopCell.startButton.isEnabled = true
        self.startStopCell.stopButton.isEnabled = false
        self.tableView.reloadData()

        // Create runData struct from run data and push to map detail view
        createRunData()
        self.navigationController?.pushViewController(MapDetailTableViewController(run:lastRun, hideSave:false), animated: true)
        // Remove timer
        timer.invalidate()
        // Stop tracking user
        locationManager.stopUpdatingLocation()
    }

    func gotoRunList() {
        self.navigationController?.pushViewController(RunListTableViewController(), animated: true)
    }

    // MARK: location tracking

    func setupLocationTracking() {
        // Start tracking location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 5
        locationManager.requestAlwaysAuthorization()
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
            if location.horizontalAccuracy < 50 {
                if self.locations.count > 0 {
                    distance += location.distance(from: self.locations.last!)
                }
                self.locations.append(location)
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

        // Calculate the pace
        let paceUnit = HKUnit.meter().unitDivided(by: HKUnit.second())
        let roundedPace = RunData.roundDouble(double: (distance/seconds), round: 2)
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: roundedPace)
        pace = paceQuantity.description
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
            i += 1
        }
        tempRun.distance = RunData.roundDouble(double: distance, round: 2)
        tempRun.time = seconds
        tempRun.pace = pace
        tempRun.locations = savedLocations
        tempRun.date = Date()
        lastRun = tempRun
    }

}

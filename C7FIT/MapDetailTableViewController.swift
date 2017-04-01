//
//  MapDetailTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/7/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MapKit
import HealthKit

class MapDetailTableViewController: UITableViewController, MKMapViewDelegate {
    
    // MARK: - Identifiers
    
    let mapCellID = "mapCell"
    let detailCellID = "detailCell"
    
    let detailCell = RunDetailCell()
    let mapCell = MapCell()
    
    // MARK: - Properties
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    var healthKitManager = HealthKitManager()
    
    var currentRun: RunData
    var userID: String?
    let hideSave: Bool
    
    
    // MARK: - Table View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.currentRun.runTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapCell.self, forCellReuseIdentifier: mapCellID)
        tableView.register(RunDetailCell.self, forCellReuseIdentifier: detailCellID)
        
        // save button
        if(!loadMap() && !hideSave) {
            print("error loading map")
            let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(cantSaveRun))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.rightBarButtonItem?.tintColor = .black
        } else if (!hideSave) {
            //display save button with correct functionality
            let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveRun))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.rightBarButtonItem?.tintColor = .black
        }
        // display run details
        detailCell.distanceQuantity.text = self.currentRun.dispDistancePretty()
        detailCell.paceQuantity.text = self.currentRun.pace
        detailCell.secondsQuantity.text = self.currentRun.dispTimePretty()
    }
    
    // MARK: - Init
    
    init(run: RunData, hideSave: Bool) {
        self.currentRun = run
        self.hideSave = hideSave
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row  == 0) {
            let cell = self.detailCell
            return cell
        } else if(indexPath.row == 1) {
            let cell = self.mapCell
            cell.mapView.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize : CGRect = UIScreen.main.bounds
        let navBarSize : CGFloat? = self.navigationController?.navigationBar.frame.size.height
        let tabBarSize : CGFloat? = self.tabBarController?.tabBar.frame.size.height
        let statusBarSize: CGFloat? = UIApplication.shared.statusBarFrame.height
        let barConstants = screenSize.height - (navBarSize! + tabBarSize! + statusBarSize!)
        let cellHeight: CGFloat = 100.0
        
        if(indexPath.row == 1) {
            return barConstants - cellHeight
        }
        return cellHeight
    }
    
    // MARK: - Map Functions
    
    //determines the maps region based on the location coordinates
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
            //center calc from min/max
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLng + maxLng)/2),
            //span to encapsulate the entire run length scaled up so view is not crowded
            span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3, longitudeDelta: (maxLng - minLng) * 1.3))
    }
    
    //renderer for the line overlay, determines how the run line will look
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
    
    //load the map
    func loadMap() -> Bool {
        if currentRun.locations.count > 0 {
            self.mapCell.mapView.isHidden = false
            
            self.mapCell.mapView.region = mapRegion()
            
            self.mapCell.mapView.add(polyline(), level: MKOverlayLevel.aboveRoads)
            return true
        } else {
            //disp error
            return false
        }
    }
    
    //save run
    func saveRun() {
        //get input for user run title
        //TODO: Check that there are no duplicates
        let runAlert = UIAlertController(title: "Run Name", message: "What do you want to name this run?", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            let runTitle = runAlert.textFields![0] as UITextField
            
            if(runTitle.text == nil || runTitle.text == "") {
                let saveError = UIAlertController(title: "Error", message: "unable to save run, please enter a valid name", preferredStyle: .alert)
                let ok = UIAlertAction(title: "okay", style: .cancel)
                saveError.addAction(ok)
                self.present(saveError, animated: true, completion:nil)
                return
            } else if ((runTitle.text?.characters.count)! > 26) {
                // stop them from entering more than 26 characers in the text field?
                let saveError = UIAlertController(title: "Error", message: "Name is too long, please be under 26 characters", preferredStyle: .alert)
                let ok = UIAlertAction(title: "okay", style: .cancel)
                saveError.addAction(ok)
                self.present(saveError, animated: true, completion:nil)
                return
            }
            
            //save the run to firebase
            self.currentRun.runTitle = runTitle.text!
            self.firebaseDataManager.monitorLoginState() { auth, user in
    
                guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion: nil) }
                self.userID = userID
                self.firebaseDataManager.updateUserRun(uid: userID, runTitle:self.currentRun.runTitle, userRun: self.currentRun)
                self.saveSuccess()
            }
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        healthKitManager.saveRun(distance: self.currentRun.distance, date: self.currentRun.date)
        
        //alert field
        runAlert.addTextField { textMinutes in
            textMinutes.placeholder = "run name"
            textMinutes.keyboardType = .alphabet
        }
        
        runAlert.addAction(submitAction)
        runAlert.addAction(cancelAction)
        self.present(runAlert, animated: true, completion: nil)
    }
    
    func saveSuccess() {
        let alert = UIAlertController(title: "Save Success", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //disp error message to user
    func cantSaveRun() {
        let alert = UIAlertController(title: "Location Data Error", message: "This run couldn't be saved sorry", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

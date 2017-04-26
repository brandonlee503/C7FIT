//
//  RunListTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class RunListTableViewController: UITableViewController, MKMapViewDelegate {

    let firebaseDataManager = FirebaseDataManager()
    var listRuns = [RunData?]()
    var userID: String?
    var numRows: Int?
    var runListCell = RunListCell()

    let runListID = "runCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Runs"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RunListCell.self, forCellReuseIdentifier: runListID)

        firebaseDataManager.monitorLoginState { _, user in
            guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion: nil) }
            self.firebaseDataManager.fetchUserRunList(uid: userID) { data in
                self.numRows = Int(data.childrenCount)
                for run in data.children.allObjects as! [FIRDataSnapshot] {
                    let json = run.value as? [String:AnyObject]
                    let tempRun = self.firebaseDataManager.buildRunFromJson(json: json!)
                    self.listRuns.append(tempRun!)
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numRows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < listRuns.count {
            if let runData = listRuns[indexPath.row] {
                if let cell: RunListCell = tableView.dequeueReusableCell(withIdentifier: runListID, for: indexPath) as? RunListCell {
                    cell.titleLabel.text = runData.runTitle
                    cell.valLabel.text = runData.dispDatePretty()
                    cell.mapView.isHidden = false
                    cell.mapView.delegate = self
                    cell.mapView.region = mapRegion(currentRun: runData)
                    cell.mapView.add(polyline(currentRun: runData), level: MKOverlayLevel.aboveRoads)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let runDetails = listRuns[indexPath.row]
        let destination = MapDetailTableViewController(run: runDetails!, hideSave:true)
        self.navigationController?.pushViewController(destination, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    // MARK: - Display mini map

    // Renderer for the line overlay, determines how the run line will look
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.black
        renderer.lineWidth = 4.0
        return renderer
    }

    // Determines the maps region based on the location coordinates
    func mapRegion(currentRun: RunData) -> MKCoordinateRegion {
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
            // Center calc from min/max
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLng + maxLng)/2),
            // Span to encapsulate the entire run length scaled up so view is not crowded
            span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3, longitudeDelta: (maxLng - minLng) * 1.3))
    }

    // Draw line from coordinates
    func polyline(currentRun: RunData) -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()

        let locations = currentRun.locations
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude,
                                                 longitude: location.longitude))
        }
        return MKPolyline(coordinates: &coords, count: currentRun.locations.count)
    }
}

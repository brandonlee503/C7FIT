//
//  RunListTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import Firebase

class RunListTableViewController: UITableViewController {
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    var listRuns = [RunData?]()
    var userID: String?
    var numRows: Int?
    var runListCell: RunListCell = RunListCell()
    
    let runListID = "runCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Runs"
        
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RunListCell.self, forCellReuseIdentifier: runListID)
        
        firebaseDataManager.monitorLoginState() { auth, user in
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if(indexPath.row < listRuns.count) {
            let rowTitle = listRuns[indexPath.row]?.runTitle ?? ""
            if let cell: RunListCell = tableView.dequeueReusableCell(withIdentifier: runListID, for: indexPath) as? RunListCell {
                cell.titleLabel.text = rowTitle
                cell.valLabel.text = listRuns[indexPath.row]?.dispDatePretty() ?? "error"
                return cell
            }
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let runDetails = listRuns[indexPath.row]
        let destination = MapDetailTableViewController(run: runDetails!, hideSave:true)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

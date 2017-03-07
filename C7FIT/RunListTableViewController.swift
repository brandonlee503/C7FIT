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
    
    let runListID = "runCell"

    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RunListTableViewCell.self, forCellReuseIdentifier: runListID)
        
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    override init(style: UITableViewStyle) {
//       
//        super.init(style: .plain)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        // #warning In0complete implementation, return the number of rows
        return numRows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < listRuns.count) {
            let rowTitle = listRuns[indexPath.row]?.runTitle ?? ""
            if let cell: RunListTableViewCell = tableView.dequeueReusableCell(withIdentifier: runListID, for: indexPath) as? RunListTableViewCell {
                cell.titleLabel.text = rowTitle
                return cell
            }
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let runDetails = listRuns[indexPath.row]
        let destination = MapDetailViewController(run: runDetails!)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

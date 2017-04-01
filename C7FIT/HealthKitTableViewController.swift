//
//  HealthKitTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/31/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitTableViewController: UITableViewController {

    let healthInfoID = "healthInfo"
    var healthKitManager = HealthKitManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Health Information"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HealthInfoCell.self, forCellReuseIdentifier: healthInfoID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 2
        case 1:
            return 7
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "General"
        case 1:
            return "Health Statistics"
        default:
            return "Other Statistics"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
                let titleLabel = "Weight"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            case 1:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
                let titleLabel = "Height"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            case 2:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)
                let titleLabel = "BMI"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            case 3:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)
                let titleLabel = "Body Fat Percentage"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            case 4:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
                let titleLabel = "Distance Ran"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            default:
                break
            }
        default:
            break
        }
        
        
        if let cell: HealthInfoCell = tableView.dequeueReusableCell(withIdentifier: healthInfoID, for: indexPath) as? HealthInfoCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func queryData(titleLabel: String, sampleType: HKSampleType) -> HealthInfoCell {
        let cell = HealthInfoCell()
        cell.titleLabel.text = titleLabel
        
        
        self.healthKitManager.queryUserData(sampleType: sampleType, completion : { (mostRecentVal, error) -> Void in
            if (error != nil){
                print("Error")
                return
            }
            
            let result = mostRecentVal as! HKQuantitySample
            DispatchQueue.main.async() {
                //better way to format info label?
                cell.infoLabel.text = String(result.quantity.description)
            }
        })
        
        return cell
    }
    


}

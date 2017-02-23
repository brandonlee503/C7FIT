//
//  HealthKitViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitViewController: UIViewController {
    
    // MARK: - Properties
    
    var healthView = HealthKit()
    var healthKitManager = HealthKitManager()
    var height, weight:HKQuantitySample?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Health"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        healthView.authButton.addTarget(self, action: #selector(authorizeHealthKit), for: .touchUpInside)
        
        self.view.addSubview(healthView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {
        healthView.translatesAutoresizingMaskIntoConstraints = false
        let topView = healthView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = healthView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = healthView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = healthView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    func authorizeHealthKit() {
        print("authorizing health kit")
        // FIXME: build error/success handling into manager
        healthKitManager.authorizeHealthKit()
        updateWeight()
    }
    
    func updateWeight() {
        let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        self.healthKitManager.queryUserData(sampleType: sampleType!, completion : { (mostRecentWeight, error) -> Void in
            if (error != nil){
                print("Error")
                return;
            }
            self.weight = mostRecentWeight as? HKQuantitySample
            let weightNum = self.weight?.quantity.doubleValue(for: HKUnit.gramUnit(with: HKMetricPrefix(rawValue: 0)!))
            //placed in different thread
            DispatchQueue.main.async() {
                //update the text async
                self.healthView.weightLabel.text = "Weight: " + String(weightNum!)
            }
        })
    }

}

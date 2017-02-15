//
//  HealthKitManager.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    let healthKitStore = HKHealthStore()
    
    // FIXME: update NSHealthUpdateUsageDescription and NSHealthShareUsageDescription from placeholder strings
    // FIXME: build error/success handling into manager
    // FIXME: figure out what data we need from Health Kit and what is available
    func authorizeHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            let healthKitRead = Set([
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                HKObjectType.workoutType()
            ])
            
            let healthKitWrite = Set([
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!
            ])
            
            healthKitStore.requestAuthorization(toShare: healthKitWrite, read: healthKitRead) { (success, error) -> Void in
                if (success == false) {
                    print("error requesting authorization")
                }
            }
        
        } else {
           return
        }
        
    }
}

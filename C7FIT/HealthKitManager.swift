//
//  HealthKitManager.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation
import HealthKit

struct HealthKitManager {

    let healthKitStore = HKHealthStore()

    // FIXME: update NSHealthUpdateUsageDescription and NSHealthShareUsageDescription from placeholder strings
    // FIXME: build error/success handling into manager
    // FIXME: figure out what data we need from Health Kit and what is available
    func authorizeHealthKit() {
        // Read data
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
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.workoutType()
            ])

        // Write data
            let healthKitWrite = Set([
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.workoutType()
            ])

            healthKitStore.requestAuthorization(toShare: healthKitWrite, read: healthKitRead) { (success, _) -> Void in
                if success == false {
                    print("error requesting authorization")
                }
            }
    }

    func queryUserData(sampleType: HKSampleType, completion: @escaping(HKSample?, NSError?) -> Void ) {
        // Predicate
        let past = NSDate.distantPast
        let now = NSDate()
        let recentPredicate = HKQuery.predicateForSamples(withStart: past, end: now as Date, options: [])

        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending:false)
        let limit = 1

        // Call query
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: recentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { _, results, error in
            if error != nil {
                completion(nil, error as NSError?)
                return
            }

            let mostRecent = results?.first as? HKQuantitySample
            if mostRecent == nil {
                // May not have permission to read data or DNE
                print("results nil")
                return
            }
            completion(mostRecent!, nil)
        }
        self.healthKitStore.execute(sampleQuery)
    }

    func saveRun(distance: Double, date: Date) {
        let hkType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)

        // Change to miles
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)

        let distanceObject = HKQuantitySample(type: hkType!, quantity: distanceQuantity, start: date, end: date)

        healthKitStore.save(distanceObject, withCompletion: { (_, error) -> Void in
            if error != nil {
                print(error as Any)
            } else {
                print("success, distance recorded")
            }
        })
    }

}

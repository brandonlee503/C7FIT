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
//    func authorizeHealthKit(completion: ((_ success:Bool,_ error: NSError) -> Void)!) {
    func authorizeHealthKit() {
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
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
                HKObjectType.workoutType()
            ])
        
//            if HKHealthStore.isHealthDataAvailable() {
//                let error = NSError(domain: "what", code: 2, userInfo: [NSLocalizedDescriptionKey:"Not available"])
//                if (completion != nil) {
//                    completion(success:false, error:error)
//                }
//                return
//            }
        
            healthKitStore.requestAuthorization(toShare: healthKitWrite, read: healthKitRead) { (success, error) -> Void in
                if (success == false) {
                    print("error requesting authorization")
                }
            }
    }
    
    func queryUserData(sampleType: HKSampleType, completion: @escaping(HKSample?, NSError?) -> Void! ){
        //predicate
        let past = NSDate.distantPast
        let now = NSDate()
        let recentPredicate = HKQuery.predicateForSamples(withStart: past, end: now as Date, options: [])
        
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending:false)
        let limit = 1
        
        //call query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: recentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
        { sampleQuery, results, error in
            if error != nil {
                completion(nil, error as NSError?)
                return
            }
        
            let mostRecent = results?.first as? HKQuantitySample
            
            if (mostRecent == nil){
                
                print("nil")
                return;
                
            }
            completion(mostRecent!, nil)
        }
        
        self.healthKitStore.execute(sampleQuery)
    }
    
}

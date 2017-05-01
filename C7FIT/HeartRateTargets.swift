//
//  HeartRateTargets.swift
//  C7FIT
//
//  Created by Michael Lee on 4/17/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import Foundation

struct HeartRateTargets {
    // swiftlint:disable large_tuple
    let beatZone: [Double: (Double, Double, Double)] = [
        20: (100, 170, 200),
        30: (95, 162, 190),
        35: (93, 157, 185),
        40: (90, 153, 180),
        45: (88, 149, 175),
        50: (85, 145, 170),
        55: (83, 140, 165),
        60: (80, 136, 160),
        65: (78, 132, 155),
        70: (75, 128, 150)
    ]
}

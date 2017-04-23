//
//  ProfilePickerDataSource.swift
//  C7FIT
//
//  Created by Brandon Lee on 4/9/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

// MARK: - PickerCellDataSource

extension ProfileViewController: PickerCellDataSource {
    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: AbstractHealthCell) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: AbstractHealthCell) -> Int {
        switch pickerView.tag {
        case 0:
            return ProfileViewModel.personalWeight.count
        case 1:
            return ProfileViewModel.personalHeight.count
        case 4, 5:
            return ProfileViewModel.repetitions.count
        case 6, 7, 8:
            return ProfileViewModel.weights.count
        default:
            return 0
        }
    }
}

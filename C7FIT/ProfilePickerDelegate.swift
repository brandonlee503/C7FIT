//
//  ProfilePickerDelegate.swift
//  C7FIT
//
//  Created by Brandon Lee on 4/9/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

// MARK: - PickerCellDelegate

/// Adapter Pattern for UIPickerView and UITableViewCells
extension ProfileViewController: PickerCellDelegate {

    func onPickerOpen(cell: AbstractHealthCell, pickerView: UIPickerView) {
        switch cell.picker.tag {
        // Start first two cases at weight 150 lbs and height 6'5" for faster navigation
        case 0:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(150, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.personalWeight[150]
                updateBMI()
            } else {
                cell.dataLabel.text = cell.dataLabel.text
            }
        case 1:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(54, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.personalHeight[54]
                updateBMI()
            } else {
                cell.dataLabel.text = cell.dataLabel.text
            }
        case 4, 5:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.repetitions[0] : cell.dataLabel.text
        case 6, 7, 8:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.weights[0] : cell.dataLabel.text
        default:
            break
        }
        cell.dataLabel.textColor = .red
    }

    func onPickerClose(_ cell: AbstractHealthCell) {
        cell.dataLabel.textColor = .black
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int, forCell cell: AbstractHealthCell) -> String? {
        switch pickerView.tag {
        case 0:
            return ProfileViewModel.personalWeight[row]
        case 1:
            return ProfileViewModel.personalHeight[row]
        case 4, 5:
            return ProfileViewModel.repetitions[row]
        case 6, 7, 8:
            return ProfileViewModel.weights[row]
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int, forCell cell: AbstractHealthCell) {
        switch pickerView.tag {
        case 0:
            cell.dataLabel.text = ProfileViewModel.personalWeight[row]
            updateBMI()
        case 1:
            cell.dataLabel.text = ProfileViewModel.personalHeight[row]
            updateBMI()
        case 4, 5:
            cell.dataLabel.text = ProfileViewModel.repetitions[row]
        case 6, 7, 8:
            cell.dataLabel.text = ProfileViewModel.weights[row]
        default:
            break
        }
    }
}

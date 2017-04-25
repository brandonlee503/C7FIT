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

    // Calibrate picker selection with the dataLabel's current text
    func onPickerOpen(cell: AbstractHealthCell, pickerView: UIPickerView) {
        switch cell.picker.tag {
        // Start first two cases at weight 150 lbs and height 5'6" for faster navigation, the rest are 0
        case 0:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(150, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.personalWeight[150]
                updateBMI()
            } else {
                pickerView.selectRow((cell.dataLabel.text?.intValue)!, inComponent: 0, animated: true)
            }
        case 1:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(54, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.personalHeight[54]
                updateBMI()
            } else {
                pickerView.selectRow(getRowFromHeight(height: cell.dataLabel.text!), inComponent: 0, animated: true)
                cell.dataLabel.text = cell.dataLabel.text
            }
        case 4, 5:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.repetitions[0]
            } else {
                pickerView.selectRow((cell.dataLabel.text?.intValue)!, inComponent: 0, animated: true)
            }
        case 6, 7, 8:
            if cell.dataLabel.text!.isEmpty {
                pickerView.selectRow(0, inComponent: 0, animated: true)
                cell.dataLabel.text = ProfileViewModel.weights[0]
            } else {
                // Increments of 5...
                pickerView.selectRow((cell.dataLabel.text?.intValue)!/5, inComponent: 0, animated: true)
            }
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

    /**
        Parses imperial height format (eg. 5'6") for row index

        - Parameter height: Height string
        - Returns Int: An integer representing the row index
     */
    func getRowFromHeight(height: String) -> Int {
        let stringArray: Array = height.components(separatedBy: .punctuationCharacters)
        return stringArray[0].intValue * 12 + stringArray[1].intValue - 12
    }
}

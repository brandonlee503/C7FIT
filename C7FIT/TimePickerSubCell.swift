//
//  TimePickerCell.swift
//  C7FIT
//
//  Created by Michael Lee on 4/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

public class TimePickerSubCell: UIView {

    // MARK: - Constants
    open let timePicker = UIPickerView()

    // MARK: - Properties
    var timeLabel = UILabel()
    open weak var delegate: TimePickerCellDelegate?
    open weak var dataSource: TimePickerCellDataSource?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Layout

    public func setup() {
        timePicker.delegate = self
        timePicker.dataSource = self
        timePicker.frame = self.frame

        self.addSubview(timePicker)
        self.addSubview(timeLabel)
    }

    public func setupConstraints() {
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        let centerPickerY = timePicker.centerYAnchor.constraint(equalTo: centerYAnchor)
        let leftPicker = timePicker.leftAnchor.constraint(equalTo: leftAnchor)
        let rightPicker = timePicker.rightAnchor.constraint(equalTo: rightAnchor)
        let topPicker = timePicker.topAnchor.constraint(equalTo: topAnchor)
        let botPicker = timePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([centerPickerY,
                                     leftPicker,
                                     rightPicker,
                                     topPicker,
                                     botPicker])

        let labelOffset: CGFloat = -50.0
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerLabelY = timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let leftLabel = timeLabel.leftAnchor.constraint(equalTo: timePicker.rightAnchor, constant: labelOffset)
        NSLayoutConstraint.activate([centerLabelY,
                                     leftLabel
                                     ])
    }

}

// MARK: - UIPickerViewDelegate

extension TimePickerSubCell: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate?.pickerView(pickerView, titleForRow: row, forComponent: component, forCell: self)
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectRow: row, inComponent: component, forCell: self)
    }
}

// MARK: - UIPickerViewDataSource

extension TimePickerSubCell: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataSource!.numberOfComponents(in: pickerView, forCell: self)
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource!.pickerView(pickerView, numberOfRowsInComponent: component, forCell: self)
    }
}

// MARK: - TimePickerCell Protocols

/// UIPickerView Hook DataSource
public protocol TimePickerCellDataSource: class {
    func numberOfComponents(in pickerView: UIPickerView, forCell cell: TimePickerSubCell) -> Int
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: TimePickerSubCell) -> Int
}

/// UIPickerView Hook Delegate
public protocol TimePickerCellDelegate: class {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: TimePickerSubCell) -> String?
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: TimePickerSubCell)
}

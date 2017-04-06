//
//  TimePickerCell.swift
//  C7FIT
//
//  Created by Michael Lee on 4/6/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

public class TimePickerCell: UIView {

    // MARK: - Constants

    open let timePicker = UIPickerView()

    // MARK: - Properties

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

        self.addSubview(timePicker)
    }

    public func setupConstraints() {
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        let centerTimeX = timePicker.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerTimeY = timePicker.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([centerTimeX, centerTimeY])

    }

}

// MARK: - UIPickerViewDelegate

extension TimePickerCell: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate?.pickerView(pickerView, titleForRow: row, forComponent: component, forCell: self)
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectRow: row, inComponent: component, forCell: self)
    }
}

// MARK: - UIPickerViewDataSource

extension TimePickerCell: UIPickerViewDataSource {
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
    func numberOfComponents(in pickerView: UIPickerView, forCell cell: TimePickerCell) -> Int
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: TimePickerCell) -> Int
}

/// UIPickerView Hook Delegate
public protocol TimePickerCellDelegate: class {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: TimePickerCell) -> String?
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: TimePickerCell)
}

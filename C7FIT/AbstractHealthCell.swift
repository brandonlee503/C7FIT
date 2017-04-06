//
//  AbstractHealthCell.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/31/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

open class AbstractHealthCell: UITableViewCell {

    // MARK: - Constants

    open let picker = UIPickerView()

    // MARK: - Properties

    var dataTitle: UILabel = UILabel()
    var dataLabel: UILabel = UILabel()

    open weak var delegate: PickerCellDelegate?
    open weak var dataSource: PickerCellDataSource?

    // MARK: - Initialization

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        picker.delegate = self
        picker.dataSource = self
        setup()
        setupConstraints()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIPickerView

    open override var canBecomeFirstResponder: Bool {
        return true
    }

    open override var canResignFirstResponder: Bool {
        return true
    }

    open override func becomeFirstResponder() -> Bool {
        picker.dataSource = self
        delegate?.onPickerOpen(cell: self, pickerView: picker)
        return super.becomeFirstResponder()
    }

    open override func resignFirstResponder() -> Bool {
        delegate?.onPickerClose(self)
        return super.resignFirstResponder()
    }

    open override var inputView: UIView? {
        return picker
    }

    // MARK: - Layout

    open func setup() {
        dataTitle.backgroundColor = .red
        addSubview(dataTitle)

        dataLabel.backgroundColor = .cyan
        addSubview(dataLabel)
    }

    open func setupConstraints() {
        dataTitle.translatesAutoresizingMaskIntoConstraints = false
        let labelLeading = dataTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let labelTop = dataTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let labelBottom = dataTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([labelLeading, labelTop, labelBottom])

        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        let fieldTrailing = dataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let fieldTop = dataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let fieldBottom = dataLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([fieldTrailing, fieldTop, fieldBottom])
    }
}

// MARK: - UIPickerViewDelegate

extension AbstractHealthCell: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate?.pickerView(pickerView, titleForRow: row, forComponent: component, forCell: self)
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectRow: row, inComponent: component, forCell: self)
    }
}

// MARK: - UIPickerViewDataSource

extension AbstractHealthCell: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataSource!.numberOfComponents(in: pickerView, forCell: self)
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource!.pickerView(pickerView, numberOfRowsInComponent: component, forCell: self)
    }
}

// MARK: - PickerCell Protocols

/// UIPickerView Hook Delegate
public protocol PickerCellDelegate: class {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: AbstractHealthCell) -> String?

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: AbstractHealthCell)

    /**
        Called on picker view open
        - Parameter cell: Target
     */
    func onPickerOpen(cell: AbstractHealthCell, pickerView: UIPickerView)

    /**
        Called on picker view close
        - Parameter cell: Target
     */
    func onPickerClose(_ cell: AbstractHealthCell)
}

/// UIPickerView Hook DataSource
public protocol PickerCellDataSource: class {
    func numberOfComponents(in pickerView: UIPickerView, forCell cell: AbstractHealthCell) -> Int
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: AbstractHealthCell) -> Int
}

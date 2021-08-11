//
//  EditDateCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditDateCell: UITableViewCell {
    
    typealias DateChangeAction = (Date) -> Void
    
    // MARK: - IBOutlets
    
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Private Properties
    
    private var dateChangeAction: DateChangeAction?
    
    // MARK: - Public Methods
    
    public func configure(dueDate: Date, changeAction: @escaping DateChangeAction) {
        datePicker.date = dueDate
        self.dateChangeAction = changeAction
    }
    
    @objc
    public func dateChanged(_ sender: UIDatePicker) {
        dateChangeAction?(sender.date)
    }
    
    // MARK: - Overridden Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
}

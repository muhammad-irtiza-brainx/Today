//
//  EditDateCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditDateCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - Public Methods
    
    public func configure(dueDate: Date) {
        datePicker.date = dueDate
    }
}

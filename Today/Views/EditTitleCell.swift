//
//  EditTitleCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditTitleCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var titleTextField: UITextField!
    
    // MARK: - Public Methods
    
    public func configure(reminderTitle: String) {
        titleTextField.text = reminderTitle
    }
}

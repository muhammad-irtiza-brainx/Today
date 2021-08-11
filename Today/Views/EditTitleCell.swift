//
//  EditTitleCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditTitleCell: UITableViewCell {
    
    typealias TitleChangeAction = (String) -> Void
    
    // MARK: - IBOutlets
    
    @IBOutlet var titleTextField: UITextField!
    
    // MARK: - Private Propertie
    
    private var titleChangeAction: TitleChangeAction?
    
    // MARK: - Public Methods
    
    public func configure(reminderTitle: String, changeAction: @escaping TitleChangeAction) {
        titleTextField.text = reminderTitle
        self.titleChangeAction = changeAction
    }
    
    // MARK: - Overridden Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleTextField.delegate = self
    }
}

extension EditTitleCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let originalText = textField.text {
            let title = (originalText as NSString).replacingCharacters(in: range, with: string)
            titleChangeAction?(title)
        }
        return true
    }
}

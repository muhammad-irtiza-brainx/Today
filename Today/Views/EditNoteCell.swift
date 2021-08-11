//
//  EditNoteCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditNoteCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var noteTextView: UITextView!
    
    // MARK: - Public Methods
    
    public func configure(reminderNote: String?) {
        guard let reminderNote = reminderNote else {
            noteTextView.text = ""
            return
        }
        noteTextView.text = reminderNote
    }
}

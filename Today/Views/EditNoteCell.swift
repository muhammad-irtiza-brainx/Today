//
//  EditNoteCell.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class EditNoteCell: UITableViewCell {
    
    typealias ChangeNoteAction = (String) -> Void
    
    // MARK: - IBOutlets
    
    @IBOutlet var noteTextView: UITextView!
    
    // MARK: - Private Properties
    
    private var noteChangeAction: ChangeNoteAction?
    
    // MARK: - Public Methods
    
    public func configure(reminderNote: String?, changeAction: ChangeNoteAction?) {
        guard let reminderNote = reminderNote else {
            noteTextView.text = ""
            return
        }
        noteTextView.text = reminderNote
        if let changeAction = changeAction {
            self.noteChangeAction = changeAction
        }
    }
    
    // MARK: - Overridden Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteTextView.delegate = self
    }
}

extension EditNoteCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let originalText = textView.text {
            let note = (originalText as NSString).replacingCharacters(in: range, with: text)
            noteChangeAction?(note)
        }
        return true
    }
}

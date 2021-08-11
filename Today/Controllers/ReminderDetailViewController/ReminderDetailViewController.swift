//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by BrainX Technologies 11 on 29/07/2021.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    
    typealias ReminderChangeAction = (Reminder) -> Void
    
    // MARK: - Static Properties
    
    static let reminderDetailCellIdentifier = "ReminderDetailCell"
    
    // MARK: - Private Properties
    
    private var reminder: Reminder?
    private var temporaryReminder: Reminder?
    private var dataSource: UITableViewDataSource?
    private var reminderChangeAction: ReminderChangeAction?
    
    // MARK: - Public Methods
    
    public func configure(reminder: Reminder, changeAction: @escaping ReminderChangeAction) {
        self.reminder = reminder
        self.reminderChangeAction = changeAction
    }
    
    @objc
    public func cancelButtonTrigger() {
        temporaryReminder = nil
        setEditing(false, animated: true)
    }
    
    // MARK: - Overridden Methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = self.reminder else {
            return
        }
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder) { reminder in
                self.temporaryReminder = reminder
                self.editButtonItem.isEnabled = true
            }
            navigationItem.title = NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
            
        } else {
            if let temporaryReminder = temporaryReminder {
                self.reminder = temporaryReminder
                self.temporaryReminder = nil
                reminderChangeAction?(temporaryReminder)
                dataSource = ReminderDetailDataSource(reminder: reminder)
            } else {
                dataSource = ReminderDetailDataSource(reminder: reminder)
            }
            navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
            navigationItem.leftBarButtonItem = nil
            editButtonItem.isEnabled = true
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditing(false, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
}

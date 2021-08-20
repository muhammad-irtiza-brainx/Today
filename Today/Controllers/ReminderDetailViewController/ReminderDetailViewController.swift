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
    
    static let reminderDetailCellIdentifier = Identifiers.reminderDetailCellIdentifier
    
    // MARK: - Private Properties
    
    private var reminder: Reminder?
    private var temporaryReminder: Reminder?
    private var dataSource: UITableViewDataSource?
    private var reminderEditAction: ReminderChangeAction?
    private var reminderAddAction: ReminderChangeAction?
    private var isNew = false
    
    // MARK: - Public Methods
    
    public func configure(reminder: Reminder, isNew: Bool = false, addAction: ReminderChangeAction? = nil, editAction: ReminderChangeAction? = nil) {
        self.reminder = reminder
        self.isNew = isNew
        self.reminderAddAction = addAction
        self.reminderEditAction = editAction
        if isViewLoaded {
            setEditing(isNew, animated: false)
        }
    }
    
    @objc
    public func cancelButtonTrigger() {
        if isNew {
            dismiss(animated: true, completion: nil)
        } else {
            temporaryReminder = nil
            setEditing(false, animated: true)
        }
    }
    
    // MARK: - File Private Methods
    
    fileprivate func transitionToEditMode(_ reminder: Reminder) {
        dataSource = ReminderDetailEditDataSource(reminder: reminder) { reminder in
            self.temporaryReminder = reminder
            self.editButtonItem.isEnabled = true
        }
        navigationItem.title = isNew ? NSLocalizedString(LocalizedKey.addReminder.string, comment: LocalizedKey.addReminderNavTitle.string) : NSLocalizedString(LocalizedKey.editReminder.string, comment: LocalizedKey.editReminderNavTitle.string)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
    }
    
    fileprivate func transitionToViewMode(_ reminder: Reminder) {
        if isNew {
            let addReminder = temporaryReminder ?? reminder
            dismiss(animated: true) {
                self.reminderAddAction?(addReminder)
            }
            return
        }
        if let temporaryReminder = temporaryReminder {
            self.reminder = temporaryReminder
            self.temporaryReminder = nil
            reminderEditAction?(temporaryReminder)
            dataSource = ReminderDetailDataSource(reminder: temporaryReminder)
        } else {
            dataSource = ReminderDetailDataSource(reminder: reminder)
        }
        navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
        navigationItem.leftBarButtonItem = nil
        editButtonItem.isEnabled = true
    }
    
    // MARK: - Overridden Methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = self.reminder else {
            return
        }
        if editing {
            transitionToEditMode(reminder)
            
        } else {
            transitionToViewMode(reminder)
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditing(isNew, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController, !navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
}

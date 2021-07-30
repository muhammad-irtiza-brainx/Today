//
//  ReminderDetailViewController.swift
//  Today
//
//  Created by BrainX Technologies 11 on 29/07/2021.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    
    // MARK: - Static Properties
    
    static let reminderDetailCellIdentifier = "ReminderDetailCell"
    
    // MARK: - Private Properties
    
    private var reminder: Reminder?
    private var reminderDetailDataSource: ReminderDetailDataSource?
    
    // MARK: - Public Methods
    
    public func configure(reminder: Reminder) {
        self.reminder = reminder
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let reminder = reminder else {
            return
        }
        reminderDetailDataSource = ReminderDetailDataSource(reminder: reminder)
        tableView.dataSource = reminderDetailDataSource
    }
}

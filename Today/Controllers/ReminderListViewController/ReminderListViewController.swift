//
//  ViewController.swift
//  Today
//
//  Created by BrainX Technologies 11 on 28/07/2021.
//

import UIKit

class ReminderListViewController: UITableViewController {
    
    // MARK:- Static Properties
    
    static let reminderListCellIndentifier = "ReminderListCell"
    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
    
    // MAKR: - Private Properties
    
    private var reminderListDataSource: ReminderListDataSource?
    
    // MARK: - Overridden Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? ReminderDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            guard let reminder = reminderListDataSource?.getReminder(at: rowIndex) else {
                return
            }
            destination.configure(reminder: reminder) { reminder in
                self.reminderListDataSource?.updateReminder(reminder, at: rowIndex)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
    }
}

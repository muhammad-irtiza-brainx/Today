//
//  ReminderListDataSource.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class ReminderListDataSource: NSObject {
    
    // MARK: - Private Properties
    
    private lazy var dateFormatter = RelativeDateTimeFormatter()
    
}

// MARK: - Data Source Methods

extension ReminderListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Reminder.reminders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderListViewController.reminderListCellIndentifier, for: indexPath) as? ReminderListCell else {
            return UITableViewCell()
        }
        let reminder = Reminder.reminders[indexPath.row]
        let customizedDateText = dateFormatter.localizedString(for: reminder.dueDate, relativeTo: Date())
        cell.configure(title: reminder.title, dateText: customizedDateText, isDone: reminder.isComplete) {
            Reminder.reminders[indexPath.row].isComplete.toggle()
        }
        return cell
    }
}

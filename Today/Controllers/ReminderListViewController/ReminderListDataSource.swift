//
//  ReminderListDataSource.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class ReminderListDataSource: NSObject {
    
    // MARK: - Public Properties
    
    public var filter: Filter = .today
    public var filteredReminders: [Reminder] {
        return Reminder.reminders.filter {
            filter.shouldInclude(date: $0.dueDate)
        }.sorted {
            $0.dueDate < $1.dueDate
        }
    }
    
    // MARK: - Public Methods
    
    public func getReminder(at row: Int) -> Reminder {
        return filteredReminders[row]
    }
    public func updateReminder(_ reminder: Reminder, at row: Int) {
        Reminder.reminders[row] = reminder
    }
    public func addReminder(_ reminder: Reminder) {
        Reminder.reminders.insert(reminder, at: 0)
    }
    
    enum Filter: Int {
        case today
        case future
        case all
        
        // MARK: - Public Methods
        
        func shouldInclude(date: Date) -> Bool {
            let isInToday = Locale.current.calendar.isDateInToday(date)
            switch self {
            case .today:
                return isInToday
            case .future:
                return (date > Date()) && !isInToday
            case .all:
                return true
            }
        }
    }
}

// MARK: - Data Source Methods

extension ReminderListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredReminders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderListViewController.reminderListCellIndentifier, for: indexPath) as? ReminderListCell else {
            return UITableViewCell()
        }
        let currentReminder = Reminder.reminders[indexPath.row]
        let dateText = currentReminder.dueDateTimeText(for: filter)
        cell.configure(title: currentReminder.title, dateText: dateText, isDone: currentReminder.isComplete) {
            Reminder.reminders[indexPath.row].isComplete.toggle()
        }
        return cell
    }
}

extension Reminder {
    
    static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter
    }()
    static let futureDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    static let todayDateFormatter: DateFormatter = {
        let format = NSLocalizedString("'Today at '%@", comment: "format string for dates occuring today")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String(format: format, "hh:mm a")
        return dateFormatter
    }()
    
    func dueDateTimeText(for filter: ReminderListDataSource.Filter) -> String {
        let isInToday = Locale.current.calendar.isDateInToday(dueDate)
        switch filter {
        case .today:
            return Self.timeFormatter.string(from: dueDate)
        case .future:
            return Self.futureDateFormatter.string(from: dueDate)
        case .all:
            if isInToday {
                return Self.todayDateFormatter.string(from: dueDate)
            } else {
                return Self.futureDateFormatter.string(from: dueDate)
            }
        }
    }
}

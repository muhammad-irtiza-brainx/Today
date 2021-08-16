//
//  Reminder.swift
//  Today
//
//  Created by BrainX Technologies 11 on 12/08/2021.
//

import UIKit

extension Reminder {
    
    // MARK: - Static Properties
    
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
        let format = NSLocalizedString(Strings.todayDateFormatString, comment: Strings.formatStringForDatesOccuringTodayString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String(format: format, Strings.hourMinuteTimeFormatString)
        return dateFormatter
    }()
    
    // MARK: - Public Methods
    
    public func dueDateTimeText(for filter: ReminderListDataSource.Filter) -> String {
        let isInToday = Locale.current.calendar.isDateInToday(dueDate)
        switch filter {
        case .today:
            return Self.timeFormatter.string(from: dueDate)
        case .future,
             .all where isInToday == false:
            return Self.futureDateFormatter.string(from: dueDate)
        case .all:
            return Self.todayDateFormatter.string(from: dueDate)
        }
    }
}

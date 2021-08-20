//
//  LocalizedKey.swift
//  Today
//
//  Created by BrainX Technologies 11 on 20/08/2021.
//

import Foundation

enum LocalizedKey: String {
    case addReminder = "Add Reminder"
    case addReminderNavTitle = "add reminder nav title"
    case editReminder = "Edit Reminder"
    case editReminderNavTitle = "edit reminder nav title"
    case today = "Today"
    case todayForDateDescription = "Today for date description"
    case title = "Title"
    case date = "Date"
    case note = "Note"
    case main = "Main"
    case newReminder = "New Reminder"
    case todayDateFormat = "'Today at '%@"
    case formatStringForDatesOccuringToday = "format string for dates occuring today"
    case hourMinuteTimeFormat = "hh:mm a"
    
    var string: String {
        return self.rawValue
    }
}

//
//  Reminder.swift
//  Today
//
//  Created by BrainX Technologies 11 on 28/07/2021.
//

import UIKit

struct Reminder {
    public var title: String
    public var dueDate: Date
    public var note: String? = nil
    public var isComplete: Bool = false
}

extension Reminder {
    static var reminders: [Reminder] = [
        Reminder(title: "Reminder No. 1", dueDate: Date().addingTimeInterval(800), note: "This is the first reminder.", isComplete: false),
        Reminder(title: "Reminder No. 2", dueDate: Date().addingTimeInterval(14_000), note: "This is the second reminder.", isComplete: true),
        Reminder(title: "Reminder No. 3", dueDate: Date().addingTimeInterval(20_000), note: "This is the third reminder.", isComplete: true),
        Reminder(title: "Reminder No. 4", dueDate: Date().addingTimeInterval(30_000), note: "This is the fourth reminder.", isComplete: true),
        Reminder(title: "Reminder No. 5", dueDate: Date().addingTimeInterval(50_000), note: "This is the fifth reminder.", isComplete: false),
        Reminder(title: "Reminder No. 6", dueDate: Date().addingTimeInterval(70_000), note: "This is the fifth reminder.", isComplete: false)
    ]
}

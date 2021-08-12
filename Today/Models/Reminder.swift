//
//  Reminder.swift
//  Today
//
//  Created by BrainX Technologies 11 on 28/07/2021.
//

import UIKit

struct Reminder {
    
    // MARK: - Public Properties
    
    public var id: String
    public var title: String
    public var dueDate: Date
    public var note: String?
    public var isComplete: Bool = false
}

extension Reminder {
    
    // MARK: - Static Properties
    
    static var reminders: [Reminder] = [
        Reminder(id: UUID().uuidString, title: "Reminder No. 1", dueDate: Date().addingTimeInterval(800), note: "This is the first reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 2", dueDate: Date().addingTimeInterval(14_000), note: "This is the second reminder.", isComplete: true),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 3", dueDate: Date().addingTimeInterval(20_000), note: "This is the third reminder.", isComplete: true),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 4", dueDate: Date().addingTimeInterval(30_000), note: "This is the fourth reminder.", isComplete: true),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 5", dueDate: Date().addingTimeInterval(50_000), note: "This is the fifth reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 6", dueDate: Date().addingTimeInterval(70_000), note: "This is the sixth reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 7", dueDate: Date().addingTimeInterval(80_000), note: "This is the seventh reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 8", dueDate: Date().addingTimeInterval(144_000), note: "This is the eighth reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 9", dueDate: Date().addingTimeInterval(200_000), note: "This is the ninth reminder.", isComplete: false),
        
        Reminder(id: UUID().uuidString, title: "Reminder No. 10", dueDate: Date().addingTimeInterval(300_000), note: "This is the tenth reminder.", isComplete: false)
    ]
}

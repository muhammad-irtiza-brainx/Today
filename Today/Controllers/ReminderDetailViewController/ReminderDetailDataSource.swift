//
//  ReminderDetailDataSource.swift
//  Today
//
//  Created by BrainX Technologies 11 on 30/07/2021.
//

import UIKit

class ReminderDetailDataSource: NSObject {
    
    // MARK: - Initializers
    
    init(reminder: Reminder) {
        self.reminder = reminder
        super.init()
    }
    
    // MARK: - Static Properties
    
    static let reminderDetailCellIdentifier = Identifiers.reminderDetailCellIdentifier
    
    // MARK: - Private Properties
    
    private var reminder: Reminder
    
    enum ReminderRow: Int, CaseIterable {
        case title
        case date
        case time
        case note
        
        // MARK: - Static Properties
        
        static let dateFormatter = DateFormatter.dateFormatter
        static let timeFormatter = DateFormatter.timeFormatter
        
        // MARK: - Public Properties
        
        public var cellImage: UIImage? {
            switch self {
            case .title:
                return nil
            case .date:
                return Images.calenderCircleIconImage
            case .time:
                return Images.clockIconImage
            case .note:
                return Images.squareAndPencilIconImage
            }
        }
        
        // MARK: - Public Methods
        
        public func displayText(for reminder: Reminder?) -> String? {
            switch self {
            case .title:
                return reminder?.title
            case .date:
                guard let date = reminder?.dueDate else {
                    return nil
                }
                if Locale.current.calendar.isDateInToday(date) {
                    return LocalizedKey.today.string
                }
                return Self.dateFormatter.string(from: date)
            case .time:
                guard let date = reminder?.dueDate else {
                    return nil
                }
                return Self.timeFormatter.string(from: date)
            case .note:
                return reminder?.note
            }
        }
    }
}

// MARK: - Data Source Methods

extension ReminderDetailDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderRow.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderDetailDataSource.reminderDetailCellIdentifier, for: indexPath) 
        let row = ReminderRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: reminder)
        cell.imageView?.image = row?.cellImage
        return cell
    }
}

//
//  ReminderDetailEditDataSource.swift
//  Today
//
//  Created by BrainX Technologies 11 on 05/08/2021.
//

import UIKit

class ReminderDetailEditDataSource: NSObject {
    
    // MARK: - Initializers
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    // MARK: - Static Properties
    
    static var dateLabelCellIdentifier: String {
        ReminderDetailSection.dueDate.cellIdentifier(for: 0)
    }
    
    // MARK: - Public Properties
    
    var reminder: Reminder
    
    // MARK: - Private Properties
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }()
    
    // MARK: - Private Methods
    
    private func dequeueAndConfigureCell(for indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = ReminderDetailSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch section {
        case .title:
            if let titleCell = cell as? EditTitleCell {
                titleCell.configure(reminderTitle: reminder.title)
            }
        case .dueDate:
            if indexPath.row == 0 {
                cell.textLabel?.text = formatter.string(from: reminder.dueDate)
            } else {
                if let dueDateCell = cell as? EditDateCell {
                    dueDateCell.configure(dueDate: reminder.dueDate)
                }
            }
        case .note:
            if let noteCell = cell as? EditNoteCell {
                noteCell.configure(reminderNote: reminder.note)
            }
            
        }
        return cell
    }
    
    enum ReminderDetailSection: Int, CaseIterable {
        case title
        case dueDate
        case note
        
        // MARK: - Public Properties
        
        var sectionTitle: String {
            switch self {
            case .title:
                return "Title"
            case .dueDate:
                return "Date"
            case .note:
                return "Note"
            }
        }
        var numOfRowsInSection: Int {
            switch self {
            case .title, .note:
                return 1
            case .dueDate:
                return 2
            }
        }
        
        // MARK: - Public Methods
        
        func cellIdentifier(for row: Int) -> String {
            switch self {
            case .title:
                return Identifiers.EditTitleCell
            case .dueDate:
                return row == 0 ? Identifiers.EditDateLabelCell : Identifiers.EditDateCell
            case .note:
                return Identifiers.EditNoteCell
            }
        }
    }
}

// MARK: - Data Source Methods

extension ReminderDetailEditDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ReminderDetailSection.allCases.count
    }
    func tableView(_ tableVoew: UITableView, numberOfRowsInSection section: Int) -> Int {
        ReminderDetailSection(rawValue: section)?.numOfRowsInSection ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueAndConfigureCell(for: indexPath, from: tableView)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ReminderDetailSection(rawValue: section) else {
            return nil
        }
        return section.sectionTitle
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

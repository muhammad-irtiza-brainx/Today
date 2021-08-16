//
//  ReminderDetailEditDataSource.swift
//  Today
//
//  Created by BrainX Technologies 11 on 05/08/2021.
//

import UIKit

class ReminderDetailEditDataSource: NSObject {
    
    typealias ReminderChangeAction = (Reminder) -> Void
    
    // MARK: - Initializers
    
    init(reminder: Reminder, changeAction: @escaping ReminderChangeAction) {
        self.reminder = reminder
        self.reminderChangeAction = changeAction
    }
    
    // MARK: - Static Properties
    
    static var dateLabelCellIdentifier: String {
        ReminderDetailSection.dueDate.cellIdentifier(for: 0)
    }
    
    // MARK: - Public Properties
    
    var reminder: Reminder
    
    // MARK: - Private Properties
    
    private var reminderChangeAction: ReminderChangeAction?
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
                titleCell.configure(reminderTitle: reminder.title) { title in
                    self.reminder.title = title
                    self.reminderChangeAction?(self.reminder)
                }
            }
        case .dueDate:
            if indexPath.row == 0 {
                cell.textLabel?.text = formatter.string(from: reminder.dueDate)
            } else {
                let dueDateCell = cell as! EditDateCell
                dueDateCell.configure(dueDate: reminder.dueDate) { date in
                    self.reminder.dueDate = date
                    self.reminderChangeAction?(self.reminder)
                    let indexPath = IndexPath(row: 0, section: section.rawValue)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        case .note:
            if let noteCell = cell as? EditNoteCell {
                noteCell.configure(reminderNote: reminder.note) { note in
                    self.reminder.note = note
                    self.reminderChangeAction?(self.reminder)
                }
            }
        }
        return cell
    }
}

// MARK: - Data Source Methods

extension ReminderDetailEditDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ReminderDetailSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

extension ReminderDetailEditDataSource {
    
    enum ReminderDetailSection: Int, CaseIterable {
        case title
        case dueDate
        case note
        
        // MARK: - Public Properties
        
        public var sectionTitle: String {
            switch self {
            case .title:
                return Strings.titleString
            case .dueDate:
                return Strings.dateString
            case .note:
                return Strings.noteString
            }
        }
        public var numOfRowsInSection: Int {
            switch self {
            case .title, .note:
                return 1
            case .dueDate:
                return 2
            }
        }
        
        // MARK: - Public Methods
        
        public func cellIdentifier(for row: Int) -> String {
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

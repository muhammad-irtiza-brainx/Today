//
//  ViewController.swift
//  Today
//
//  Created by BrainX Technologies 11 on 28/07/2021.
//

import UIKit

class ReminderListViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    // MARK: - IBActions
    
    @IBAction
    func addButtonTriggered(_ sender: UISegmentedControl) {
        addReminder()
    }
    @IBAction
    func segmentControlChanged(_ sender: UISegmentedControl) {
        reminderListDataSource?.filter = filter
        tableView.reloadData()
    }
    
    // MARK:- Static Properties
    
    static let reminderListCellIndentifier = "ReminderListCell"
    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
    static let mainStoryboardName = "Main"
    static let detailViewControllerIdentifier = "ReminderDetailViewController"
    
    // MARK: - Private Properties
    
    private var reminderListDataSource: ReminderListDataSource?
    private var filter: ReminderListDataSource.Filter {
        return ReminderListDataSource.Filter(rawValue: filterSegmentedControl.selectedSegmentIndex) ?? .today
    }
    
    // MARK: - Private Methods
    
    private func addReminder() {
        let storyboard = UIStoryboard(name: Self.mainStoryboardName, bundle: nil)
        let detailViewController: ReminderDetailViewController = storyboard.instantiateViewController(identifier: Self.detailViewControllerIdentifier)
        let reminder = Reminder(id: UUID().uuidString ,title: "New Reminder", dueDate: Date())
        detailViewController.configure(reminder: reminder, isNew: true, addAction: { reminder in
            if let index = self.reminderListDataSource?.addReminder(reminder) {
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        })
        let navigationController = UINavigationController(rootViewController: detailViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
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
            destination.configure(reminder: reminder, editAction: { reminder in
                self.reminderListDataSource?.updateReminder(reminder, at: rowIndex)
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController, navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(false, animated: animated)
        }
    }
}

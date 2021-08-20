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
    @IBOutlet var progressContainerView: UIView!
    @IBOutlet var percentIncompleteView: UIView!
    @IBOutlet var percentCompleteView: UIView!
    @IBOutlet var percentCompleteHeightConstraint: NSLayoutConstraint!
    
    // MARK: - IBActions
    
    @IBAction
    func addButtonTriggered(_ sender: UISegmentedControl) {
        addReminder()
    }
    @IBAction
    func segmentControlChanged(_ sender: UISegmentedControl) {
        reminderListDataSource?.filter = self.filter
        tableView.reloadData()
        self.refreshProgressView()
    }
    
    // MARK:- Static Properties
    
    static let reminderListCellIndentifier = Identifiers.reminderListCellIdentifier
    static let showDetailSegueIdentifier = Identifiers.showReminderDetailSegueIndentifier
    static let mainStoryboardName = LocalizedKey.main.string
    static let detailViewControllerIdentifier = Identifiers.reminderDetailViewControllerIdentifier
    
    // MARK: - Private Properties
    
    private var reminderListDataSource: ReminderListDataSource?
    private var filter: ReminderListDataSource.Filter {
        return ReminderListDataSource.Filter(rawValue: filterSegmentedControl.selectedSegmentIndex) ?? .today
    }
    
    // MARK: - Private Methods
    
    private func addReminder() {
        let detailViewController = UIViewController.instantiate(ReminderDetailViewController.self, fromStoryboard: .Main)
        let reminder = Reminder(id: UUID().uuidString, title: LocalizedKey.newReminder.string, dueDate: Date())
        
        detailViewController.configure(reminder: reminder, isNew: true, addAction: { reminder in
            if let index = self.reminderListDataSource?.addReminder(reminder) {
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                self.navigationController?.popViewController(animated: true)
            }
        })
        navigationController?.pushViewController(detailViewController, animated: true)
        self.refreshProgressView()
    }
    
    private func refreshProgressView() {
        guard let percentComplete = reminderListDataSource?.percentCompleted else {
            return
        }
        let totalHeight = progressContainerView.bounds.size.height
        percentCompleteHeightConstraint.constant = totalHeight * CGFloat(percentComplete)
        UIView.animate(withDuration: 0.2) {
            self.progressContainerView.layoutSubviews()
        }
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
                self.refreshProgressView()
            })
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        reminderListDataSource = ReminderListDataSource(
            reminderCompletedAction: { reminderIndex in
            self.tableView.reloadRows(at: [IndexPath(row: reminderIndex, section: 0)], with: .automatic)
            self.refreshProgressView()
            }, reminderDeletedAction: {
                self.refreshProgressView()
        })
        tableView.dataSource = reminderListDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController, navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(false, animated: animated)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let radius = view.bounds.size.width * 0.5 * 0.7
        progressContainerView.layer.cornerRadius = radius
        progressContainerView.layer.masksToBounds = true
        self.refreshProgressView()
    }
}

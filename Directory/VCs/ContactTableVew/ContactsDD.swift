//
//  ContactsDD.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import Foundation
import UIKit

class ContactsDD: NSObject, UITableViewDelegate, UITableViewDataSource {
    var contactTable: UITableView!
    var refreshControl = UIRefreshControl()

    var employees = [Employee]()
    var isFirstLoad = true
    var sortOption = SortOptions.name

    init(_ tableView: UITableView?) {
        super.init()

        guard let tableView = tableView else { return }
        contactTable = tableView

        contactTable.delegate = self
        contactTable.dataSource = self
        contactTable.separatorStyle = .none
        setupRefresh()
    }
    private func setupRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        contactTable.addSubview(refreshControl)
    }
    @objc func refresh() {
        Requests.shared.getEmployees { (employees) in
            self.employees = employees
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.sort(by: self.sortOption)
                self.contactTable.reloadData()

                if (self.employees.isEmpty) {
                    self.contactTable.isHidden = true
                } else {
                    self.contactTable.isHidden = false
                }
            }
        }
    }
    func sort(_ employees: [Employee], _ by: SortOptions) -> [Employee] {
        sortOption = by
        var employeeArray = [Employee]()
        if (by == .name) {
            employeeArray = employees.sorted { (first, second) -> Bool in
                guard let first = first.full_name, let second = second.full_name else { return false }
                return first < second
            }
        } else if (by == .team) {
            employeeArray = employees.sorted { (first, second) -> Bool in
                guard let first = first.team, let second = second.team else { return false }
                return first < second
            }
        }
        return employeeArray
    }
    func sort(by: SortOptions) {
        employees = sort(employees, by)
        contactTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactCell

        let contact = employees[indexPath.row]

        cell.cardView.layer.cornerRadius = 15
        cell.uuid = contact.uuid

        cell.profileImage.setColor(.black)
        cell.profileImage.loadImageFrom(url: contact.photo_url_small)

        cell.nameLabel.text = contact.full_name ?? "---"
        cell.emailLabel.text = contact.email_address ?? "---"
        cell.teamLabel.text = "Department: " + (contact.team ?? "---")
        cell.employmentLabel.text = contact.getEmployeeType()
        cell.selectionStyle = .none

        return cell
    }
}

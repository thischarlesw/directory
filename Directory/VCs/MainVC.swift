//
//  MainVC.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var segementedSort: UISegmentedControl!
    @IBOutlet weak var contactsTable: UITableView!

    var contactsDD: ContactsDD!

    override func viewDidLoad() {
        super.viewDidLoad()

        segementedSort.setTitle("Name", forSegmentAt: 0)
        segementedSort.setTitle("Team", forSegmentAt: 1)
        segementedSort.selectedSegmentTintColor = #colorLiteral(red: 0.9946373105, green: 0.3121625185, blue: 0.3781090975, alpha: 1)

        contactsDD = ContactsDD(contactsTable)
        contactsDD.refresh()
    }
    @IBAction func sort(_ sender: Any) {
        if (segementedSort.selectedSegmentIndex == 0) {
            contactsDD.sort(by: .name)
        } else {
            contactsDD.sort(by: .team)
        }
    }
}
enum SortOptions {
    case name
    case team
}

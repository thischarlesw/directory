//
//  EmployeeModel.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import Foundation

class Employees: Codable {
    let employees : [Employee]
}
class Employee: Codable {
    let uuid            : String? // required
    let full_name       : String? // required
    let email_address   : String? // required
    let team            : String? // required
    private let employee_type : String? // required

    let phone_number    : String?
    let biography       : String?
    let photo_url_small : String?
    let photo_url_large : String?

    init(uuid: String,
         fullName: String,
         email: String,
         team: String,
         employeeType: String,
         phoneNumber: String? = nil,
         biography: String? = nil,
         smallPhoto: String? = nil,
         largePhoto: String? = nil) {
        self.uuid               = uuid
        self.full_name          = fullName
        self.email_address      = email
        self.team               = team
        self.employee_type      = employeeType

        self.phone_number       = phoneNumber
        self.biography          = biography
        self.photo_url_small    = smallPhoto
        self.photo_url_large    = largePhoto
    }

    func getEmployeeType() -> String {
        var status = "Employment: "
        switch employee_type {
        case "FULL_TIME":
            status += "Full Time"
        case "PART_TIME":
            status += "Part Time"
        case "CONTRACTOR":
            status += "Contractor"
        default:
            status += "---"
        }

        return status
    }
}

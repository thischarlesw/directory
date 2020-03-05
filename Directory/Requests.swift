//
//  Requests.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import Foundation

class Requests {
    static let shared = Requests()

    let employees = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    let malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    let empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"

    func getEmployees(_ urlType: URLType = .employees, _ completion: @escaping ([Employee]) -> Void) {
        guard let url = URL(string: employees) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var employees = [Employee]()
            guard let data = data else { return }
            if let employeesJSON = try? JSONDecoder().decode(Employees.self, from: data) {
                employees = employeesJSON.employees
            }
            if let response = response {
                let code = (response as! HTTPURLResponse).statusCode
                print(code)
            }
            completion(employees)
        }
        task.resume()
    }
    enum URLType {
        case employees
        case malformed
        case empty
    }
}

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

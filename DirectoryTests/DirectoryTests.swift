//
//  DirectoryTests.swift
//  DirectoryTests
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//
//
import XCTest
@testable import Directory

class DirectoryTests: XCTestCase {
    var employees           = [Employee]()
    var malformedEmployees  = [Employee]()
    var emptyEmployees      = [Employee]()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let aEmployee = Employee(uuid: "1", fullName: "A", email: "A", team: "Z", employeeType: "FULL_TIME")
        let bEmployee = Employee(uuid: "2", fullName: "B", email: "B", team: "Y", employeeType: "PART_TIME")
        let cEmployee = Employee(uuid: "3", fullName: "C", email: "C", team: "X", employeeType: "CONTRACTOR")

        employees = [aEmployee, bEmployee, cEmployee]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSort() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let contactsDD = ContactsDD(nil)

        let teamOrder = contactsDD.sort(employees, .team)
        XCTAssert(teamOrder[0].team! == "X")
        XCTAssert(teamOrder[1].team! == "Y")
        XCTAssert(teamOrder[2].team! == "Z")

        let nameOrder = contactsDD.sort(employees, .name)
        XCTAssert(nameOrder[0].full_name! == "A")
        XCTAssert(nameOrder[1].full_name! == "B")
        XCTAssert(nameOrder[2].full_name! == "C")
    }
    func testEmployeeTypeParse() {
        let dEmployee = Employee(uuid: "4", fullName: "D", email: "D", team: "D", employeeType: "D")
        employees.append(dEmployee)

        for employee in employees {
            switch employee.uuid {
            case "1":
                XCTAssert(employee.getEmployeeType() == "Employment: Full Time")
            case "2":
                XCTAssert(employee.getEmployeeType() == "Employment: Part Time")
            case "3":
                XCTAssert(employee.getEmployeeType() == "Employment: Contractor")
            default:
                XCTAssert(employee.getEmployeeType() == "Employment: ---")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

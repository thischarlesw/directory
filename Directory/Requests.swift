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

    func setupCache() {
        let memoryCap = 500 * 1024 * 1024
        let diskCap = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCap, diskCapacity: diskCap, diskPath: "myDirectory")
        URLCache.shared = urlCache
    }

    func getEmployees(_ urlType: URLType = .employees, _ completion: @escaping ([Employee]) -> Void) {
        setupCache()
        guard let url = URL(string: employees) else { return }
        let request = URLRequest(url: url)

        if let response = URLCache.shared.cachedResponse(for: request) {
            var employees = [Employee]()
            if let employeesJSON = try? JSONDecoder().decode(Employees.self, from: response.data) {
                employees = employeesJSON.employees
            }
            let code = (response.response as! HTTPURLResponse).statusCode
            print("Cached", code)

            completion(employees)
        } else {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                var employees = [Employee]()
                guard let data = data else { return }
                if let employeesJSON = try? JSONDecoder().decode(Employees.self, from: data) {
                    employees = employeesJSON.employees
                }
                if let response = response {
                    let code = (response as! HTTPURLResponse).statusCode
                    print("Live", code)
                }
                completion(employees)
            }
            task.resume()
        }
    }
    enum URLType {
        case employees
        case malformed
        case empty
    }
}

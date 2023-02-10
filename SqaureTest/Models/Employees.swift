//
//  Employees.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

struct Employees: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case employees
    }
    
    let employees: [Employee]
    
    init(employees: [Employee]) {
        self.employees = employees
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let employees = try container.decode([Employee].self, forKey: .employees)
        self.init(employees: employees)
    }
}

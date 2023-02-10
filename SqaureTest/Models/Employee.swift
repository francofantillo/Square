//
//  Employee.swift
//  SqaureTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

struct Employee: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case email = "remail_address"
        case bio = "biography"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
    
    let uuid : String
    let fullName: String
    let phoneNumber: String!
    let email: String
    let bio: String!
    let photoURLSmall: String!
    let photoURLLarge: String!
    let team: String
    let employeeType: String
}

extension Employee: Hashable {
    static let example = Employee(uuid: "vrefd", fullName: "Jack", phoneNumber: "2507449410", email: "email", bio: "blah", photoURLSmall: "test", photoURLLarge: "test2", team: "team1", employeeType: "bro")
}

//
//  Employee.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

struct Employee: Codable, Comparable {
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.fullName < rhs.fullName
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case email = "email_address"
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
    
    init(uuid: String, fullName: String, phoneNumber: String?, email: String, bio: String?, photoURLSmall: String?, photoURLLarge: String?, team: String, employeeType: String){
        self.uuid = uuid
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.email = email
        self.bio = bio
        self.photoURLSmall = photoURLSmall
        self.photoURLLarge = photoURLLarge
        self.team = team
        self.employeeType = employeeType
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let uuid = try container.decode(String.self, forKey: .uuid)
        let fullName = try container.decode(String.self, forKey: .fullName)
        let phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        let email = try container.decode(String.self, forKey: .email)
        let bio = try container.decodeIfPresent(String.self, forKey: .bio)
        let photoURLSmall = try container.decodeIfPresent(String.self, forKey: .photoURLSmall)
        let photoURLLarge = try container.decodeIfPresent(String.self, forKey: .photoURLLarge)
        let team = try container.decode(String.self, forKey: .team)
        let employeeType = try container.decode(String.self, forKey: .employeeType)
        self.init(uuid: uuid, fullName: fullName, phoneNumber: phoneNumber, email: email, bio: bio, photoURLSmall: photoURLSmall, photoURLLarge: photoURLLarge, team: team, employeeType: employeeType)
    }
}

extension Employee: Hashable {
    static let example = Employee(uuid: "vrefd", fullName: "Jack", phoneNumber: "2507449410", email: "email", bio: "blah", photoURLSmall: "test", photoURLLarge: "test2", team: "team1", employeeType: "bro")
}

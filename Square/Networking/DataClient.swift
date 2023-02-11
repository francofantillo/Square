//
//  DataClient.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

class DataClient {

	let client: HttpClient
	
	init(client: HttpClient) {
		
		self.client = client
	}
	
	func getEmployees() async throws -> [Employee] {

		let path = "/sq-mobile-interview/employees.json"
        let malformed = "/sq-mobile-interview/employees_malformed.json"
        let empty = "/sq-mobile-interview/employees_empty.json"
		let url = try constructURLFromComponents(path: path, queryItems: [])
		let data = try await client.getData(url: url)
		let employees = try JSONDecoder().decode(Employees.self, from: data)
        return employees.employees
	}
	
	private func constructURLFromComponents(path: String, queryItems: [URLQueryItem]) throws -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "s3.amazonaws.com"
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        guard let url = components.url else {
                throw APIErrors.invalidRequestError
        }
        return url
	}
}

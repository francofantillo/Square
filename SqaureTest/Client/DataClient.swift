//
//  DataClient.swift
//  SquareTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

class DataClient {

	let client: HttpClient
	let apiKey: String
	
	init(client: HttpClient, apiKey: String) {
		
		self.client = client
		self.apiKey = apiKey
	}
	
	func getEmployees() async throws -> [Employee] {

		let path = "/sq-mobile-interview/employees.json"
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

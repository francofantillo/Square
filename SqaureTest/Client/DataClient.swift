//
//  DataClient.swift
//  SquareTest
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

public class DataClient {

	let client: HttpClient
	let apiKey: String
	let baseUrl: URL
	
	public init(client: HttpClient, apiKey: String) {
		
		self.client = client
		self.apiKey = apiKey
		
		guard let url = URL(string: "https://api.themoviedb.org/3/") else {
			preconditionFailure("Unable to build URL")
		}
		self.baseUrl = url
	}
	

	
	private func constructURLFromComponents(path: String, queryItems: [URLQueryItem]) throws -> URL {
			
			var components = URLComponents()
			components.scheme = "https"
			components.host = "api.themoviedb.org"
			components.path = path
			components.queryItems = queryItems
			guard let url = components.url else {
					throw APIErrors.invalidRequestError
			}
			return url
	}
}

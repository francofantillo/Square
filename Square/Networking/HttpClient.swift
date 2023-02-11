//
//  HttpClient.swift
//  Square
//
//  Created by Franco Fantillo on 2023-02-09.
//

import Foundation

//MARK: HttpClient Implementation
public class HttpClient {
    
    typealias completeClosure = ( _ result: Result<(Data, URLResponse), Error>) -> Void
    
    private let session: URLSessionProtocol
    
    private var dataTask: URLSessionDataTaskProtocol!
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
	func getData(url: URL) async throws -> Data {
		
		// Check if another task is running and cancel it if it is
		if let task = dataTask {
			task.cancel()
		}
		
		let headers = ["content-type": "application/json;charset=utf-8"]
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.allHTTPHeaderFields = headers
		return try await withCheckedThrowingContinuation { continuation in
			dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
				
				guard let self1 = self else {
					continuation.resume(with: .failure(APIErrors.validationError("Self is out of scope.")))
					return
				}
				
				if let error = error {
                    // If the datatask is cancelled it will throw this error
					if error.localizedDescription == "cancelled" {
						return
					}
					continuation.resume(with: .failure(APIErrors.transportError("Http get failed.")))
					return
				}
				
				switch self1.checkResponse(response: response, data: data){
				case .failure(let error):
					continuation.resume(with: .failure(error))
					return
				case .success(let data):
					continuation.resume(with: .success(data))
					return
				}
				
			}
			dataTask.resume()
		}
	}
    
    private func checkResponse(response: URLResponse?, data: Data?) -> Result<Data, APIErrors> {
        
        guard let urlResponse = response as? HTTPURLResponse else {
            return .failure(APIErrors.invalidResponseError)
        }

        if (200..<300) ~=  urlResponse.statusCode {
            print(urlResponse.statusCode)
            guard let data = data else { return .failure(APIErrors.validationError("Unable to decode api error.")) }
            return .success(data)
        }
        else {
            guard let data = data else { return .failure(APIErrors.validationError("Unable to decode api error.")) }
            
            let decoder = JSONDecoder()
            do {
                let apiError = try decoder.decode(APIErrorMessage.self, from: data)
                
                if (400..<499) ~=  urlResponse.statusCode {
                    return .failure(APIErrors.validationError("Failed with status code:  \(urlResponse.statusCode).  Reason: \(apiError.reason)"))
                }
                
                if 500 <= urlResponse.statusCode {
                    return .failure(APIErrors.validationError("Failed with status code:  \(urlResponse.statusCode).  Reason: \(apiError.reason)"))
                }
                
            } catch {
                return .failure(APIErrors.validationError("Unable to decode api error."))
            }
        }
        fatalError("Should never reach this.")
    }
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

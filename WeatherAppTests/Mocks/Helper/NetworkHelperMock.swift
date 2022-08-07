//
//  NetworkHelperMock.swift
//  WeatherAppTests
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

@testable import WeatherApp

class NetworkHelperMock: NetworkHelper {
    var didCallGet: Bool = false
    var didCallGetUrl: String?
    var didCallGetQueryParams: [String: String]?
    var didCallGetCompletion: Any?

    func get<T>(url urlString: String,
                queryParams: [String: String],
                responseType: T.Type,
                completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        didCallGet = true
        didCallGetUrl = urlString
        didCallGetQueryParams = queryParams
        didCallGetCompletion = completion
    }

    func resolve<T: Decodable>(with result: Result<T, NetworkError>) {
        if let completion = didCallGetCompletion as? (Result<T, NetworkError>) -> Void {
            completion(result)
        }
    }
}

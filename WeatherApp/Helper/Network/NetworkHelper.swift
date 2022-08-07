//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by Gabriel Azzinnari on 7/8/22.
//

import Foundation

// This interface could be improved / replaced by another one that's better suited for additional REST operations and use cases.
// This time it's used as an abstraction layer on top of URLSession to improve code testability.
protocol NetworkHelper {
    func get<T: Decodable>(url urlString: String,
                           queryParams: [String: String],
                           responseType: T.Type,
                           completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkHelperDefault: NetworkHelper {
    func get<T>(url: String,
                queryParams: [String: String],
                responseType: T.Type,
                completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let url = getURL(urlString: url, queryParams: queryParams) else {
            completion(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard error == nil else {
                completion(.failure(.underlyingError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.errorStatus))
                return
            }
            guard let data = data,
                  let result = try? self.parseResponseBody(data: data, responseType: responseType) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(result))
        }
        task.resume()
    }

    private func getURL(urlString: String, queryParams: [String: String]) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }

    private func parseResponseBody<T: Decodable>(data: Data, responseType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(responseType, from: data)
    }
}

enum NetworkError: Error {
    case internalServerError
    case invalidUrl
    case errorStatus
    case decodingError
    case underlyingError
}

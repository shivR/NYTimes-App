//
//  APINetworkClient.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation
import Dispatch
import Combine

protocol APINetworkClientProtocol {
    func startService<T>(_ service: BaseService) -> AnyPublisher<T, APIError> where T: Decodable
}

final class APINetworkClient {
    private var session: URLSession
    private struct Constants {
        static let apiKeyValue = "LfRTC85jjydmr65Gkx7lgoieMqhHgvoH"
        static let apikey = "api-key"
        static let scheme = "http"
        static let host = "api.nytimes.com"
    }

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    private func createRequest(_ service: BaseService) -> URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = service.endpoint
        components.queryItems = [
            URLQueryItem(
                name: Constants.apikey,
                value: Constants.apiKeyValue
            )
        ]

        if let requestParams = service.requestParameters {
            for (key, value) in requestParams {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
        }

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = service.httpMethod
        return request
    }
}

extension APINetworkClient: APINetworkClientProtocol {
    func startService<T>(_ service: BaseService) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let request = createRequest(service) else {
            return Fail(error: .network(description: "RequestInvalid")).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap { result in
                decode(data: result.data)
            }
            .eraseToAnyPublisher()
    }
}

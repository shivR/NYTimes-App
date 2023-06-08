//
//  GenericParser.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation
import Combine

func decode<T: Decodable>(data: Data) -> AnyPublisher<T, APIError> {
    return Just(data)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error in
                .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

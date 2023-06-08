//
//  Service.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation

enum HttpMethod: String {
    case GET
}

protocol BaseService {
    var endpoint: String { get }
    var httpMethod: String { get }
    var requestParameters: [String: String]? { get }
}

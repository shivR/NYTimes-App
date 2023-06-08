//
//  APIError.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation

enum APIError: Error {
case parsing(description: String)
case network(description: String)
}

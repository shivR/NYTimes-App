//
//  Utility.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//
//  MockDataProvider.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation

class MockDataProvider {
    static func mockArticleModel() -> ArticleModel {
        guard let pathString = Bundle(for: self).url(forResource: "articles", withExtension: "json") else {
            fatalError("articles.json not found")
        }

        guard let jsonData = try? Data(contentsOf: pathString) else {
            fatalError("Unable to convert articles.json to Data")
        }
        
        guard let articleModel = try? JSONDecoder().decode(ArticleModel.self, from: jsonData) else {
            fatalError("Unable to convert articles.json to Article model")
        }
        
        return articleModel
    }
}

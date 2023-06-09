//
//  ArticleWorker.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Combine

typealias ArticleResult = AnyPublisher<ArticleModel, APIError>

protocol ArticleWorkerLogic {
    func getArticles() -> ArticleResult
}

final class ArticleWorker: ArticleWorkerLogic {
    private var networkClient: APINetworkClientProtocol

    init(_ networkClient: APINetworkClientProtocol = APINetworkClient()) {
        self.networkClient = networkClient
    }

    func getArticles() -> ArticleResult {
        let service = ArticleService(route: .mostviewed)
        return networkClient.startService(service)
    }
}

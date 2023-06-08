//
//  NYTimes_AppTests.swift
//  NYTimes-AppTests
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import XCTest
import Combine

@testable import NYTimes_App

final class ArticleListViewModelTests: XCTestCase {
    var viewModel: ArticleListViewModelProtocol?

    override func setUpWithError() throws {
        viewModel = ArticleListViewModel(articleWorker: ArticleMockWorker())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchCities() {
        let expectation = self.expectation(description: "Fetching Cities")
        viewModel?.reloadView = {
            expectation.fulfill()
        }
        viewModel?.fetchArticles()
        waitForExpectations(timeout: 5, handler: nil)
                
        XCTAssertEqual(viewModel?.itemAtIndex(index: 0)?.byline, "By Nate Cohn", "Auther name is not matching")
        XCTAssertEqual(viewModel?.numberOfRows, 20, "article count should be 20")
    }
}

final class ArticleMockWorker {
    
}

extension ArticleMockWorker: ArticleWorkerLogic {
    func getTopCities() -> ArticleResult {
        return Just(MockDataProvider.mockArticleModel())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

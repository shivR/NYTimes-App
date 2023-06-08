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

    func testGetArticles() {
        let expectation = self.expectation(description: "Fetching Articles")
        viewModel?.reloadView = {
            expectation.fulfill()
        }
        viewModel?.fetchArticles()
        waitForExpectations(timeout: 5, handler: nil)
                
        XCTAssertEqual(viewModel?.itemAtIndex(index: 0)?.byline, "By Nate Cohn", "Auther name is not matching")
        XCTAssertEqual(viewModel?.numberOfRows, 20, "articles count should be 20")
    }
    
    func testArticlesError() {
        viewModel = ArticleListViewModel(articleWorker: ArticleErrorMockWorker())
        let expectation = self.expectation(description: "Fetching Articles")
        var dataError: String?
        viewModel?.showError = { error in
            dataError = error
            expectation.fulfill()
        }
        viewModel?.fetchArticles()
        waitForExpectations(timeout: 5, handler: nil)
                
        XCTAssertNotNil(dataError, "Error should not be null")
    }
}

final class ArticleMockWorker: ArticleWorkerLogic {
    func getArticles() -> ArticleResult {
        return Just(MockDataProvider.mockArticleModel())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

final class ArticleErrorMockWorker: ArticleWorkerLogic {
    func getArticles() -> ArticleResult {
        return Fail(error: .network(description: "Something went wrong"))
            .eraseToAnyPublisher()
    }
}

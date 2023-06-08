//
//  ArticleDetailViewModelTests.swift
//  NYTimes-AppTests
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import XCTest

final class ArticleDetailViewModelTests: XCTestCase {
    var viewModel: ArticleDetailViewModelProtocol?
    
    override func setUpWithError() throws {
        viewModel = ArticleDetailViewModel(article: MockDataProvider.mockArticleModel().results[0])
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testArticle() {
        XCTAssertEqual(viewModel?.title, "Millennials Are Not an Exception. They’ve Moved to the Right.", "title is not matching")
        XCTAssertEqual(viewModel?.auther, "By Nate Cohn", "auther is not matching")
        
        let description = "Over the last decade, almost every cohort of voters under 50 has shifted rightward."
        XCTAssertEqual(viewModel?.description, description, "description is not matching")
        
        let largeImage = "https://static01.nyt.com/images/2023/05/31/multimedia/2023-05-31-nate-millennial-promo-index/2023-05-31-nate-millennial-promo-index-mediumThreeByTwo440-v2.png"
        XCTAssertEqual(viewModel?.image, largeImage, "image is not matching")
        
        XCTAssertEqual(viewModel?.detailLink, "https://www.nytimes.com/2023/06/01/upshot/millennials-polling-politics-republicans.html", "link is not matching")
    }
}

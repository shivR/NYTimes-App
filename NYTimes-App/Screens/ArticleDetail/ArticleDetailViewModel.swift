//
//  ArticleDetailViewModel.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import Foundation

protocol ArticleDetailViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var auther: String { get }
    var detailLink: String { get }
    var image: String? { get }
}

final class ArticleDetailViewModel {
    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
}

extension ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    var title: String {
        article.title
    }
    
    var description: String {
        article.abstract
    }
    
    var image: String? {
        article.media.first?.mediaMetadata.last?.url
    }
    
    var auther: String {
        article.byline
    }
    
    var detailLink: String {
        article.url
    }
}

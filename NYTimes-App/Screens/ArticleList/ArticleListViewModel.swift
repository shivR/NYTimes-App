//
//  ArticleListViewModel.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import SwiftUI
import Combine

protocol ArticleListViewModelProtocol: BaseViewModel {
    func fetchArticles()
    var numberOfRows: Int { get }
    func itemAtIndex(index: Int) -> Article?
}

final class ArticleListViewModel  {
    var showIndicator: (Bool) -> Void = {_ in }
    var reloadView: () -> Void = {}
    var showError: (String) -> Void = {_ in }
    
    private var articles: [Article] = [] {
        didSet {
            reloadView()
        }
    }
    
    private var error: String? {
        didSet {
            showError(error ?? "")
        }
    }
    
    private var articleWorker: ArticleWorkerLogic
    private var disposables = Set<AnyCancellable>()
    
    init(articleWorker: ArticleWorkerLogic) {
        self.articleWorker = articleWorker
    }
}

extension ArticleListViewModel: ArticleListViewModelProtocol {
    func fetchArticles() {
        showIndicator(true)
        articleWorker.getArticles()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: {[weak self] result in
                guard let self = self else { return }
                self.articles = result.results
                self.showIndicator(false)
            }
            .store(in: &disposables)
    }
    
    var numberOfRows: Int {
        articles.count
    }

    func itemAtIndex(index: Int) -> Article? {
        return articles[safe: index]
    }
}

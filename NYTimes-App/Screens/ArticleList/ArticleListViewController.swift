//
//  ArticleListViewController.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import UIKit

class ArticleListViewController: UITableViewController {
    var articleListViewModel: ArticleListViewModelProtocol?

    private struct Constant {
        static let cellIdentifier = "cell"
        static let cellNib = "ArticleListTableViewCell"
        static let detailView = "detail"
    }
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "NY Times Most Popular"
        tableView.register(
            UINib(nibName: Constant.cellNib, bundle: .main),
            forCellReuseIdentifier: Constant.cellIdentifier
        )
        
        setupListeners()
        articleListViewModel?.fetchArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? ArticleDetailViewController,
              let article = sender as? Article
        else { return }

        detailVC.articleDetailViewModel = ArticleDetailViewModel(article: article)
    }
}

// MARK: ViewModel listener
extension ArticleListViewController {
    private func setupListeners() {
        articleListViewModel?.reloadView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        articleListViewModel?.showIndicator = {[weak self] shouldShow in
            guard let self = self else { return }
            DispatchQueue.main.async {
                shouldShow ? self.showIndicator() : self.hideIndicator()
            }
        }

        articleListViewModel?.showError = {[weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(message: error)
            }
        }
    }
}

// MARK: TVC DataSource
extension ArticleListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListViewModel?.numberOfRows ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constant.cellIdentifier,
            for: indexPath) as? ArticleListTableViewCell
        else { return UITableViewCell() }

        cell.article = articleListViewModel?.itemAtIndex(index: indexPath.row)
        return cell
    }
}

// MARK: TVC Delegates
extension ArticleListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constant.detailView, sender: articleListViewModel?.itemAtIndex(index: indexPath.row))
    }
}

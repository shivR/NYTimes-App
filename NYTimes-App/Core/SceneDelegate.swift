//
//  SceneDelegate.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        guard let articleListNVC = windowScene.windows.first?.rootViewController as? UINavigationController,
              let articleListVC = articleListNVC.viewControllers.first as? ArticleListViewController else {
            return
        }
        articleListVC.articleListViewModel = ArticleListViewModel(articleWorker: ArticleWorker())
    }
}


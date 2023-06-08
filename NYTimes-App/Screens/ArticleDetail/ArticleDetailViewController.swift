//
//  ArticleDetailViewController.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var descriptionLabel: UILabel!
    @IBOutlet weak private(set) var imageView: UIImageView!
    @IBOutlet weak private(set) var autherLabel: UILabel!
    
    var articleDetailViewModel: ArticleDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Detail"
        setupView()
    }
    
    @IBAction func tappedOnMoreDetail(_ sender: UITapGestureRecognizer) {
        guard let detailLink = articleDetailViewModel?.detailLink,
              let url = URL(string: detailLink)
        else { return }
        UIApplication.shared.open(url)
    }
}

extension ArticleDetailViewController {
    private func setupView() {
        titleLabel.text = articleDetailViewModel?.title
        descriptionLabel.text = articleDetailViewModel?.description
        autherLabel.text = articleDetailViewModel?.auther
        guard let image = articleDetailViewModel?.image,
              let imageUrl = URL(string: image)
        else { return }
        imageView.kf.setImage(with: imageUrl)
    }
}

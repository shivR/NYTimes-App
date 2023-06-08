//
//  ArticleListTableViewCell.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import UIKit
import Kingfisher

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet weak private(set) var articleImageView: UIImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var autherLabel: UILabel!
    @IBOutlet weak private(set) var dateLabel: UILabel!
    
    var article: Article? {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        guard let article = article else { return }
        
        titleLabel.text = article.title
        autherLabel.text = article.byline
        dateLabel.text = article.publishedDate
        
        guard let image = article.media.first?.mediaMetadata.first?.url,
        let imageUrl = URL(string: image) else { return }
        articleImageView.kf.setImage(with: imageUrl)
    }
}

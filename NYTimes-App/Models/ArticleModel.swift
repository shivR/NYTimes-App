//
//  CityModel.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

// MARK: - ArticleModel
struct ArticleModel: Codable {
    let results: [Article]
}

// MARK: - Article
struct Article: Codable {
    let url: String
    let publishedDate: String
    let byline: String
    let title, abstract: String
    let media: [Media]

    enum CodingKeys: String, CodingKey {
        case url
        case publishedDate = "published_date"
        case byline, title, abstract
        case media
    }
}

// MARK: - Media
struct Media: Codable {
    let mediaMetadata: [MediaMetada]

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetada: Codable {
    let url: String
}

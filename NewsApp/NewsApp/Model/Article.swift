//
//  Article.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import Foundation

// MARK: - Article
struct Article {
    var source: Source?
    var author: String?
    var title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: NSNumber?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard var label = label else { return nil }
            if label == "articleDescription" {
                label = "description"
            }
          return (label, value)
        }).compactMap { $0 })
        return dict
      }
    
    init(dict: [String: Any]) {
        if let _source = dict[CodingKeys.source.rawValue] as? [String: Any] {
            self.source = Source(dict: _source)
        }
        self.author = dict[CodingKeys.author.rawValue] as? String
        self.title = dict[CodingKeys.title.rawValue] as? String
        self.title = dict[CodingKeys.title.rawValue] as? String
        self.articleDescription = dict[CodingKeys.articleDescription.rawValue] as? String
        self.url = dict[CodingKeys.url.rawValue] as? String
        self.urlToImage = dict[CodingKeys.urlToImage.rawValue] as? String
        self.publishedAt = dict[CodingKeys.publishedAt.rawValue] as? NSNumber
        self.content = dict[CodingKeys.content.rawValue] as? String
    }
    
    static func setData(data: [[String: Any]]) -> [Article] {
        var articles = [Article]()
        for dict in data {
            let a = Article(dict: dict)
            articles.append(a)
        }
        return articles
    }
}

// MARK: - Source
struct Source {
    var id: String?
    var name: String?
    
    init(dict: [String: Any]) {
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
    }
}

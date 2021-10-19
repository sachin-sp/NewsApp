//
//  CDArticle+CoreDataClass.swift
//  NewsApp
//
//  Created by Sachin on 19/10/21.
//
//

import Foundation
import CoreData

@objc(CDArticle)
public class CDArticle: NSManagedObject, Codable {
    
    //From api response key if changed
    enum apiKey: String, CodingKey {
        case id
        case author
        case title
        case url
        case urlToImage
        case articleDescription = "description"
    }
    
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        
        ///Fetch context for codable
        guard let codableContext = CodingUserInfoKey.init(rawValue: "context"),
            let manageObjContext = decoder.userInfo[codableContext] as? NSManagedObjectContext,
            let manageObjList = NSEntityDescription.entity(forEntityName: "CDArticle", in: manageObjContext) else {
                fatalError("failed")
        }
        
        self.init(entity: manageObjList, insertInto: manageObjContext)
        let container = try decoder.container(keyedBy: apiKey.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: apiKey.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(articleDescription, forKey: .articleDescription)
    }
}

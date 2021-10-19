//
//  CDArticle+CoreDataProperties.swift
//  NewsApp
//
//  Created by Sachin on 19/10/21.
//
//

import Foundation
import CoreData


extension CDArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }

    @NSManaged public var id: String?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var articleDescription: String?

}

extension CDArticle : Identifiable {

}

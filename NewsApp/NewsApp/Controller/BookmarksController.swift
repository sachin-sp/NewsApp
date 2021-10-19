//
//  BookmarksController.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import UIKit

class BookmarksController: UIViewController {

    var articleViewModel: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Bookmarks"
        articleViewModel = ArticleViewModel(frame: view.frame, homeViewModelDelegate: self)
        view.addSubview(articleViewModel)
        getBookmarks()

    }

    func getBookmarks() {
        let bookmarks = CoreDataMaganer.shared.fetchBookmarkArticles()
        var bookmarksData = [[String: Any]]()
        for article in bookmarks {
            let author = article.author
            let title = article.title
            let articleDescription = article.articleDescription
            let url = article.url
            let urlToImage = article.urlToImage
            
            var dict = [String: Any]()
            dict["author"] = author
            dict["title"] = title
            dict["description"] = articleDescription
            dict["url"] = url
            dict["urlToImage"] = urlToImage
            
            bookmarksData.append(dict)
            
        }
        articleViewModel.articles = Article.setData(data: bookmarksData)
    }
}

extension BookmarksController: HomeViewModelDelegate {
    
    func didSelectArticle(index: Int, article: Article) {
        let vc = DetailController()
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

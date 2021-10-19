//
//  DetailController.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import UIKit
import WebKit

class DetailController: UIViewController {

    var webView: WKWebView!
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let bookmarkButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(bookmarkAction))
        self.navigationItem.rightBarButtonItem = bookmarkButton
        setupView()
        loadWebView()

    }
    
    func setupView() {
        webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func loadWebView() {
        
        let urlStr = self.article?.url ?? ""
        guard let url = URL(string: urlStr) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc func bookmarkAction() {
        if var articleDict = self.article?.asDictionary {
            articleDict.removeValue(forKey: Article.CodingKeys.source.rawValue)
            articleDict.removeValue(forKey: Article.CodingKeys.content.rawValue)
            articleDict.removeValue(forKey: Article.CodingKeys.author.rawValue)
            articleDict.removeValue(forKey: Article.CodingKeys.publishedAt.rawValue)
            CoreDataMaganer.shared.insertBookmarkArticle(article: articleDict)
        }
    }

}


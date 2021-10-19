//
//  HomeController.swift
//  NewsApp
//
//  Created by Sachin on 18/10/21.
//

import UIKit

class HomeController: UIViewController {
    
    var articleViewModel: ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Home"
        articleViewModel = ArticleViewModel(frame: view.frame, homeViewModelDelegate: self)
        view.addSubview(articleViewModel)
        APIManager.getNews { [weak self] (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response else {
                return
            }
            if let _articles = response["articles"] as? [[String: Any]]{
                self?.articleViewModel.articles = Article.setData(data: _articles)
            }
        }
        
    }
    
}
extension HomeController: HomeViewModelDelegate {
    
    func didSelectArticle(index: Int, article: Article) {
        let vc = DetailController()
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



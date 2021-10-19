//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Sachin on 19/10/21.
//

import UIKit

protocol HomeViewModelDelegate: class {
    func didSelectArticle(index: Int, article: Article)
}

class ArticleViewModel: UIView {
    
    weak var homeViewModelDelegate: HomeViewModelDelegate?
    
    lazy var _collectionView: UICollectionView = {
        let layout = self.createCollectionViewLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemGroupedBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.cellIdentifier)
        return cv
    }()
    
    var articles: [Article]? {
        didSet {
            DispatchQueue.main.async {
                self._collectionView.reloadData()
            }
        }
    }
    
    
    init(frame: CGRect, homeViewModelDelegate: HomeViewModelDelegate) {
        super.init(frame: frame)
        self.homeViewModelDelegate = homeViewModelDelegate
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(_collectionView)
        _collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        _collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        _collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        _collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

extension ArticleViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.cellIdentifier, for: indexPath)
        as! ArticleCell
        if let article = self.articles?[indexPath.item] {
            cell.setData(article: article)
        }
        return cell
    }
}

extension ArticleViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if let article = self.articles?[indexPath.item] {
            homeViewModelDelegate?.didSelectArticle(index: indexPath.item, article: article)
        }
    }
    
}

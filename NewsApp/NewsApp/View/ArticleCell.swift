//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Sachin on 19/10/21.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .center
        return iv
    }()
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 12)
        return l
    }()
    
    private func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(label)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -4).isActive = true
        
        label.heightAnchor.constraint(equalToConstant: frame.height / 2).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
    }
    
    func setData(article: Article) {
        self.label.text = article.articleDescription ?? ""
        if let imageUrl = article.urlToImage {
            if let url = URL(string: imageUrl) {
                imageView.downloaded(from: url)
            }
        }
    }
    
}

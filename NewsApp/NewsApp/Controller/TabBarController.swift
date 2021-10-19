//
//  TabBarController.swift
//  NewsApp
//
//  Created by Sachin on 19/10/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = HomeController()
        let homeNavigation = UINavigationController(rootViewController: homeController)
        homeNavigation.tabBarItem.title = "Home"


        let bookmarksController = BookmarksController()
        let bookmarksNavigation = UINavigationController(rootViewController: bookmarksController)
        bookmarksNavigation.tabBarItem.title = "Bookmarks"
        
        viewControllers = [homeNavigation, bookmarksNavigation]

    }

}

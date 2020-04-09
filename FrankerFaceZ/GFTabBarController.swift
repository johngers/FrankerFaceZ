//
//  GFTabBarController.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createSearchNC(),createEmoteNC(), createFavoritesNC()]
        // Do any additional setup after loading the view.
    }
    
    func createSearchNC() -> UINavigationController {
           let searchVC = ViewController()
           searchVC.title = "Search"
          // searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
            searchVC.tabBarItem = UITabBarItem(title: "Search Channels", image: UIImage(systemName: "magnifyingglass"), tag: 0)
           
           return UINavigationController(rootViewController: searchVC)
       }
    
    func createSettingsNC() -> UINavigationController {
        let settingsVC = SettingsVC()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        
        return UINavigationController(rootViewController: settingsVC)
    }
    


    
    func createEmoteNC() -> UINavigationController {
              let emoteVC = EmoteSearchVC()
              emoteVC.title = "Emotes"
        //emoteVC.tabBarItem = UITabBarItem(tabBarSystemItem: , tag: 1)
            emoteVC.tabBarItem = UITabBarItem(title: "Infinite Wall", image: UIImage(systemName: "text.justify"), tag: 1)
              
              return UINavigationController(rootViewController: emoteVC)
        }
       
       func createFavoritesNC() -> UINavigationController {
           let favoritesListVC = FavoritesListVC()
           favoritesListVC.title = "Favorites"
           favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
           
           return UINavigationController(rootViewController: favoritesListVC)
       }
    
}


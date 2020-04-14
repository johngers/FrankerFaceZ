//
//  FavoritesListVC.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/3/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit
import SafariServices

class FavoritesListVC: LoadingViewController {
    
    let tableView = UITableView()
    var favorites:[Emoticon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewController()
        configureTableView()
        
        let button: UIButton = UIButton(type: .system)
        //set image for button
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.tintColor = .systemPurple
        //add function for button
        button.addTarget(self, action: #selector(editTable), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let editButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
       navigationItem.rightBarButtonItem = editButton
        
        
    }
    
    @objc func editTable() {
        self.tableView.isEditing = true
        
        let button: UIButton = UIButton(type: .system)
         //set image for button
         button.setTitle("Done", for: .normal)
         button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
         button.tintColor = .systemPurple
         //add function for button
         button.addTarget(self, action: #selector(doneEditingTable), for: .touchUpInside)
         //set frame
         button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
         
         let doneButton = UIBarButtonItem(customView: button)
         //assign button to navigationbar
        navigationItem.rightBarButtonItem = doneButton
         
    }
    
    @objc func doneEditingTable() {
        self.tableView.isEditing = false
        
        let error = PersistenceManager.save(favorites: favorites)
        
        if error != nil {
            presentGFAlertOnMainThread(title: "Unable to save favorites", message: "Please try again", buttonTitle: "Ok")
        }
        
        let button: UIButton = UIButton(type: .system)
        //set image for button
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.tintColor = .systemPurple
        //add function for button
        button.addTarget(self, action: #selector(editTable), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let editButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        doneEditingTable()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        //tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retreiveFavorites { [weak self] (result) in
            guard let self = self else {return}
            
            self.updateUI(with: result)
            
        }
    }
    
    func updateUI(with favorites:[Emoticon]) {
        if favorites.isEmpty {
            self.removeTableShowEmptyState()
            
        } else {
            self.favorites = favorites
            self.view.addSubview(self.tableView)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    func removeTableShowEmptyState() {
           for view in self.view.subviews {
               view.removeFromSuperview()
           }
           self.showEmptyStateView(with: "\nNo favorites.", in: self.view)
            self.navigationItem.rightBarButtonItem = nil
       }
    
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let cell = FavoriteCell(style: .default, reuseIdentifier: FavoriteCell.reuseID)
        
        cell.selectionStyle = .none
        let favorite = favorites[indexPath.row]
        cell.set(emote: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        
        let emote = favorites[indexPath.row]
        
        let infoVC = EmoteInfoVC(emote: emote, url: currentCell.emoteURL, image: currentCell.avatarImageView.image!)
        let navController = UINavigationController(rootViewController: infoVC)
        present(navController, animated: true)
        
        //        guard let url = URL(string: currentCell.emoteURL) else {
        //            return
        //        }
        //        let safariVC = SFSafariViewController(url: url)
        //        safariVC.preferredControlTintColor = .systemPurple
        //        // let ac = UIActivityViewController(activityItems: [streamerEmotes[sender.tag].urls["2"]!], applicationActivities: nil)
        //        present(safariVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        showLoadingView()
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            self.dismissLoadingView()
            guard let _ = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.favorites.isEmpty {
                    self.removeTableShowEmptyState()
                }
                return
            }
            //self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        //let emote = favorites[indexPath.row]
        
        let shareButton = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), handler: { action in
            let ac = UIActivityViewController(activityItems: [currentCell.avatarImageView.image!], applicationActivities: nil)
            self.present(ac, animated: true)
        })
        
        let favoriteButton = UIAction(title: "Remove from favorites", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { action in
            self.showLoadingView()
            PersistenceManager.updateWith(favorite: self.favorites[indexPath.row], actionType: .remove) { [weak self] (error) in
                guard let self = self else { return }
                self.dismissLoadingView()
                guard let _ = error else {
                    self.favorites.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                    if self.favorites.isEmpty {
                        self.removeTableShowEmptyState()
                    }
                    return
                }
                //self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        })
        
        let newMenu = UIMenu(title: "", options: .displayInline, children: [shareButton, favoriteButton])
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedAction in
            return newMenu
        })
    
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.favorites[sourceIndexPath.row]
        favorites.remove(at: sourceIndexPath.row)
        favorites.insert(movedObject, at: destinationIndexPath.row)
    }
    
    
    
}

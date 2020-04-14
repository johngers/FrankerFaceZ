//
//  EmoteSearchVC.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/4/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit
import SafariServices

class EmoteSearchVC: LoadingViewController {
    
    
    let tableView  = UITableView()
    
    var pageNumber:Int = 1
    var totalPages: Int = 0
    var pageEmotes:[Emoticon] = []
    let searchController                    = UISearchController()
    var searchString:String = ""
    static var sortString:String = ""
    
    var isSearching: Bool = false
    
    var buttonChecked: ButtonChecked = .second
    //var ascDesc:String = "descending"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Emotes"
        // Do any additional setup after loading the view.
        configureScrollView()
        configureSearchController()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        
        let button: UIButton = UIButton(type: .system)
        //set image for button
        button.setTitle("Sort", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.tintColor = .systemPurple
        //add function for button
        button.addTarget(self, action: #selector(sortChoice), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let sortButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        navigationItem.rightBarButtonItem = sortButton
        
        createDiscover()
        EmoteSearchVC.sortString = "created-desc"
        
        showLoadingView()
        NetworkManager.shared.getPage(search: "", pageNumber: pageNumber, completed: { (emotes, pages) in
            self.dismissLoadingView()
            print("PAGEGGGEHEEGEG NUMBERRRRR: \(self.pageNumber)")
            self.pageEmotes.append(contentsOf: emotes!)
            self.totalPages = pages
            self.updateUI()
        })
    }
    
    func updateUI() {
        filterEmotes(pageEmotes: &pageEmotes)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func sortChoice() {
        print("Search string: \(searchString)")
        let optionMenu = createActionSheet(searchString: searchString)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func discoverEmote() {
        let randomPage = Int.random(in: 1...totalPages)
        EmoteSearchVC.sortString = ""
        //let randomPage = 4132
        showLoadingView()
        NetworkManager.shared.getPage(search: "", pageNumber: randomPage, completed: { (emotes, pages) in
            self.dismissLoadingView()
            self.pageNumber = randomPage
            print("PAGEGGGEHEEGEG NUMBERRRRR: \(self.pageNumber) Total pages: \(self.totalPages)")
            self.pageEmotes = emotes!
            self.updateUI()
            self.createReset()
        })
    }
    
    @objc func resetTable() {
        pageNumber = 1
        EmoteSearchVC.sortString = ""
        navigationItem.title = "Emotes"
        searchString = ""
        buttonChecked = .second
        showLoadingView()
        NetworkManager.shared.getPage(search: searchString, pageNumber: pageNumber, completed: { (emotes, pages) in
            self.dismissLoadingView()
            self.totalPages = pages
            print("PAGEGGGEHEEGEG NUMBERRRRR: \(self.pageNumber) Total pages: \(self.totalPages)")
            self.pageEmotes = emotes!
            self.updateUI()
           
            self.createDiscover()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func configureScrollView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        //searchController
        searchController.searchBar.placeholder  = "Search for an emote"
        navigationItem.searchController         = searchController
    }
    
    func createDiscover() {
        let dButton: UIButton = UIButton(type: .system)
        //set image for button
        dButton.setTitle("Discover", for: .normal)
        dButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        dButton.tintColor = .systemPurple
        //add function for button
        dButton.addTarget(self, action: #selector(discoverEmote), for: .touchUpInside)
        //set frame
        dButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let discoverButton = UIBarButtonItem(customView: dButton)
        //assign button to navigationbar
        DispatchQueue.main.async {
            self.navigationItem.leftBarButtonItem = discoverButton
        }
    }
    
    func createReset() {
        let rButton: UIButton = UIButton(type: .system)
        //set image for button
        rButton.setTitle("Reset", for: .normal)
        rButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        rButton.tintColor = .systemPurple
        //add function for button
        rButton.addTarget(self, action: #selector(self.resetTable), for: .touchUpInside)
        //set frame
        rButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let resetButton = UIBarButtonItem(customView: rButton)
        //assign button to navigationbar
        DispatchQueue.main.async {
            self.navigationItem.leftBarButtonItem = resetButton
        }
    }
}

extension EmoteSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard totalPages > pageNumber, isSearching == false else {return}
            pageNumber = pageNumber + 1
            //getPage(endpoint: "https://api.frankerfacez.com/v1/emoticons?page=\(pageNumber)")
            isSearching = true
            showLoadingView()
            NetworkManager.shared.getPage(search: searchString, pageNumber: pageNumber, completed: { (emotes, pages) in
                self.dismissLoadingView()
                self.isSearching = false
                print("PAGEGGGEHEEGEG NUMBERRRRR: \(self.pageNumber)")
                self.pageEmotes.append(contentsOf: emotes!)
                self.totalPages = pages
                self.updateUI()
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pageEmotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let cell = FavoriteCell(style: .default, reuseIdentifier: FavoriteCell.reuseID)
        cell.selectionStyle = .none
        let emote = pageEmotes[indexPath.row]
        cell.set(emote: emote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        
        let emote = pageEmotes[indexPath.row]
        
        let infoVC = EmoteInfoVC(emote: emote, url: currentCell.emoteURL, image: currentCell.avatarImageView.image!)
        let navController = UINavigationController(rootViewController: infoVC)
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
           let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
           let emote = pageEmotes[indexPath.row]
           
           let shareButton = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), handler: { action in
               let ac = UIActivityViewController(activityItems: [currentCell.avatarImageView.image!], applicationActivities: nil)
               self.present(ac, animated: true)
           })
           
           let favoriteButton = UIAction(title: "Add to favorites", image: UIImage(systemName: "star"), handler: { action in
               self.addButtonTapped(emote: emote)
           })
           
           let newMenu = UIMenu(title: "", options: .displayInline, children: [shareButton, favoriteButton])
           
           return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedAction in
               return newMenu
           })
       
       }
}

extension EmoteSearchVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.navigationItem.title = "Emotes"
        }
        searchString = ""
        pageNumber = 1
        pageEmotes.removeAll()
        EmoteSearchVC.sortString = ""
        showLoadingView()
        NetworkManager.shared.getPage(search: searchString, pageNumber: pageNumber) { (emotes, pages) in
            self.dismissLoadingView()
            self.pageEmotes.append(contentsOf: emotes!)
            self.totalPages = pages
            self.createDiscover()
            self.updateUI()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            pageEmotes.removeAll()
            pageNumber = 1
            showLoadingView()
            NetworkManager.shared.getPage(search: searchString, pageNumber: pageNumber, completed: { (emotes, pages) in
                self.dismissLoadingView()
                self.pageEmotes.append(contentsOf: emotes!)
                self.totalPages = pages
                self.updateUI()
            })
            return
        }
        isSearching = true
        pageNumber = 1
        pageEmotes.removeAll()
        updateUI()
        searchString = searchController.searchBar.text!
        searchController.isActive = false
        EmoteSearchVC.sortString = "count-desc"
        buttonChecked = .tenth
        DispatchQueue.main.async {
            self.navigationItem.title = self.searchString
        }
        showLoadingView()
        NetworkManager.shared.getPage(search: searchString, pageNumber: pageNumber, completed: { (emotes, pages) in
            self.dismissLoadingView()
            self.pageEmotes.append(contentsOf: emotes!)
            self.totalPages = pages
            self.isSearching = false
            self.createReset()
            self.updateUI()
        })
    }
}


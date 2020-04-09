//
//  EmoteListVC.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/2/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit
import SafariServices

class EmoteListVC: LoadingViewController {
    
    let tableView  = UITableView()
    let contentView = UIView()
    
    var channelName: String = ""
    var streamerEmotes: [Emoticon] = []
    static var emoteURLs:[String] = []
    
    init(channel:String) {
        super.init(nibName: nil, bundle: nil)
        //streamerEmotes = emotes
        channelName = channel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.title = channelName
        navigationController?.navigationBar.prefersLargeTitles = true
        configureViewController()
        configureScrollView()
        tableView.delegate = self
        tableView.dataSource = self
        print(streamerEmotes.count)
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        showLoadingView()
        NetworkManager.shared.getChannel(channelName: channelName) { (emotes) in
            self.dismissLoadingView()
            guard emotes!.count != 0 else {
                self.presentGFAlertOnMainThread(title: "Streamer not found", message: "Check that you entered the full channel name and that this streamer has FFZ emotes enabled", buttonTitle: "Ok")
                return
            }
            self.streamerEmotes = emotes!
            for _ in 0..<self.streamerEmotes.count {
                for j in 1..<self.streamerEmotes.count {
                    if self.streamerEmotes[j].name.lowercased() < self.streamerEmotes[j-1].name.lowercased() {
                        let temp = self.streamerEmotes[j-1]
                        self.streamerEmotes[j-1] = self.streamerEmotes[j]
                        self.streamerEmotes[j] = temp
                    }
                }
                
            }
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.title = NetworkManager.displayName
            self.tableView.reloadData()
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
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
    
}

extension EmoteListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        streamerEmotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        cell.selectionStyle = .none
        let emote = streamerEmotes[indexPath.row]
        cell.set(emote: emote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        
        let emote = streamerEmotes[indexPath.row]
        
        let infoVC = EmoteInfoVC(emote: emote, url: currentCell.emoteURL, image: currentCell.avatarImageView.image!)
        let navController = UINavigationController(rootViewController: infoVC)
        present(navController, animated: true)
        
        //addButtonTapped(emote: emote)
        
        //        let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
        //
        //        guard let url = URL(string: currentCell.emoteURL) else {
        //                   return
        //               }
        //               let safariVC = SFSafariViewController(url: url)
        //               safariVC.preferredControlTintColor = .systemPurple
        //               // let ac = UIActivityViewController(activityItems: [streamerEmotes[sender.tag].urls["2"]!], applicationActivities: nil)
        //               present(safariVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
           let currentCell = tableView.cellForRow(at: indexPath) as! FavoriteCell
           let emote = streamerEmotes[indexPath.row]
           
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

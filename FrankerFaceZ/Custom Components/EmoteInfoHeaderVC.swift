//
//  GFUserInfoHeaderVC.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit
import SafariServices

class EmoteInfoHeaderVC: LoadingViewController {
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontsize: 30)
    let nameLabel           = GFSecondayTitleLabel(fontSize: 20)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondayTitleLabel(fontSize: 20)
    
    let urlButton = GFButton(backgroundColor: .systemPurple, title: "Open Emote")
    let favoritesButton = GFButton(backgroundColor: .systemGreen, title: "Add emote to favorites")
    
    var emote: Emoticon!
    var emoteURL:String!
    
    init(emote:Emoticon, url:String, image:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.emote = emote
        self.emoteURL = url
        self.avatarImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, urlButton, favoritesButton)
        layoutUI()
        configureUIElements()
        configureButtons()
        // Do any additional setup after loading the view.
    }
    
    func configureUIElements() {
        downloadImageHelper(url: emoteURL)
        usernameLabel.text          = emote.name
        //nameLabel.text              = emote.owner.displayName
        NetworkManager.shared.getEmoteOwner(emote: emote) { (owner) in
            DispatchQueue.main.async {
                self.nameLabel.text = owner.owner.displayName
                self.locationLabel.text = String(owner.usageCount)
            }
        }
      
        locationImageView.image     = UIImage(systemName: "person")
        locationImageView.tintColor = .secondaryLabel
    }
    
    private func configureButtons() {
        urlButton.addTarget(self, action: #selector(urlButtonTapped), for: .touchUpInside)
        favoritesButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
    }
    
    @objc func urlButtonTapped() {
        guard let url = URL(string: emoteURL) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemPurple
        // let ac = UIActivityViewController(activityItems: [streamerEmotes[sender.tag].urls["2"]!], applicationActivities: nil)
        present(safariVC, animated: true)
    }
    
    @objc func favoritesButtonTapped() {
        addButtonTapped(emote: emote)
    }
    
    func downloadImageHelper(url:String) {
           downloadImage(from: url, completed: { (image) in
               guard image != nil else { return }
               DispatchQueue.main.async {
                   self.avatarImageView.image = image
               }
           })
       }
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        
        guard let url = URL(string: "\(urlString)") else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let _ = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            completed(image)
        }
        task.resume()
    }
    
    func layoutUI() {
        let padding:CGFloat = 20
        let textImagePadding:CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
               
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            //usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 3/5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
           // nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            //locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            

            urlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50),
           // urlButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
          //  urlButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            urlButton.widthAnchor.constraint(equalToConstant: 300),
            urlButton.heightAnchor.constraint(equalToConstant: 50),

            favoritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoritesButton.topAnchor.constraint(equalTo: urlButton.bottomAnchor, constant: 50),
           // favoritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
           // favoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            favoritesButton.widthAnchor.constraint(equalToConstant: 300),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            

        ])
    }
}


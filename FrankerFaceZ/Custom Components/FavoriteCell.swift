//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID  = "FavoriteCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontsize: 20)
    var emoteURL:String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(emote: Emoticon) {
        usernameLabel.text = emote.name
        //print(emote.urls["4"] ?? nil)
        if var url = emote.urls["4"] {
            url = "https:\(url)"
            emoteURL = url
            downloadImageHelper(url: url)
        }
        else if var url = emote.urls["2"] {
            url = "https:\(url)"
            emoteURL = url
            downloadImageHelper(url: url)
        }
        else if var url = emote.urls["1"] {
            url = "https:\(url)"
            emoteURL = url
            downloadImageHelper(url: url)
        }
        else {
            DispatchQueue.main.async {
                self.avatarImageView.image = UIImage(systemName: "person")
            }
        }
        
    }
    
    func downloadImageHelper(url:String) {
        downloadImage(from: url, completed: { (image) in
            guard image != nil else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        })
    }
    
//    func downloadImageHelper2(url:String) {
//           downloadImage(from: url, completed: { (image) in
//               guard image != nil else { return }
//               DispatchQueue.main.async {
//                self.avatarImageView.image = UIImage.gifImageWithURL(url)
//               }
//           })
//       }
    
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
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.contentMode = .scaleAspectFit
        
        accessoryType = .disclosureIndicator
//        var imageView : UIImageView
//        imageView  = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
//        accessoryView = imageView
        
//        let checkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        checkButton.addTarget(self, action:#selector(FavoriteCell.checkTapped),
//            for: .touchUpInside)
//        checkButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
//        accessoryView = checkButton
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}


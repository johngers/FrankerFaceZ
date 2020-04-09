//
//  GFAvatarImageView.swift
//  GitHub Followers
//
//  Created by John Gers on 3/29/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = UIImage(systemName: "hourglass")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
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
}


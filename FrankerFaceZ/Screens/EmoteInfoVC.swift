//
//  UserInfoVC.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class EmoteInfoVC: LoadingViewController {
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    //let dateLabel   = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var emote:Emoticon!
    var url:String!
    var image = UIImage()
    var imageView = UIImageView()
    
    init(emote:Emoticon, url:String, image:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.emote = emote
        self.url = url
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        configureUIElements()
        //downloadImageHelper(url: url)
    }
    
    func configureViewController() {
        view.backgroundColor    = .systemBackground
    
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(shareEmote), for: .touchUpInside)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        let shareButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        navigationItem.leftBarButtonItem = shareButton
        
        let doneButton          = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
        
    }
    
    func getUserInfo() {
        
    }
    
    func configureUIElements() {
        self.add(childVC: EmoteInfoHeaderVC(emote: emote, url: url, image: image), to: self.headerView)
    }
    
    func layoutUI() {
        itemViews = [headerView]
        let padding: CGFloat    = 20
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
            
            
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 600),
        
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func shareEmote() {
        //bring up share sheet
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(ac, animated: true)
    }
    
//    func downloadImageHelper(url:String) {
//              downloadImage(from: url, completed: { (image) in
//                  guard image != nil else { return }
//                  DispatchQueue.main.async {
//                    self.image = image!
//                  }
//              })
//          }
//
//       func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
//
//           guard let url = URL(string: "\(urlString)") else {
//               completed(nil)
//               return
//           }
//           let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//               guard let _ = self,
//                   error == nil,
//                   let response = response as? HTTPURLResponse, response.statusCode == 200,
//                   let data = data,
//                   let image = UIImage(data: data) else {
//                       completed(nil)
//                       return
//               }
//               completed(image)
//           }
//           task.resume()
//       }
    
    @objc func addButtonHelper() {
        addButtonTapped(emote: emote)
        
    }
    
}


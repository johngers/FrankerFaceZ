//
//  UIViewController+Ext.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/9/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit


extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func filterEmotes(pageEmotes:inout [Emoticon]) {
        for emote in pageEmotes {
            if emote.name.lowercased().contains("pepe") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("alex") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("peepo") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("feels") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("gers") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("monk") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("pers") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("ez") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("pepo") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("monak") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("allgood") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("pp") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("weirdpala") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("peforg") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("appenirl") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("dank") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("hands") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("jammies") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("riotbeta") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("corona") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("wow1") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("cock") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("gentman") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("nope") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("yep") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("hype") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("jna") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("pausers") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("stenni") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("mapthief") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("voteno") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("voteyes") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("dbreadu") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("heh") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("weedsout") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("poop") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("giga") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("tenseW") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("gladCe") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("zeranga") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("woaf") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("catge") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("huhh") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("shit") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("sadge") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("mayo") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("mitch") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("weirdga") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("okayge") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("1xomg") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("yerp") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("matler") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("nopw") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("fuck") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("ass") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("butt") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("peepe") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("dick") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("poggies") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("ree") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("bruh") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("booty") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("kek") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("froglaugh") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("froglach") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("frogstarf") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("frogka") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("frog3") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("meow") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("cheek") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("blood") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("boob") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("bum") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("wank") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            else if emote.name.lowercased().contains("smilers") {
                pageEmotes.removeAll { (emoticon) -> Bool in
                    emoticon == emote
                }
            }
            
        }
    }
    
}


class LoadingViewController:UIViewController {
    
    var containerView: UIView!

       override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
    }
    
    func showLoadingView() {
          containerView = UIView(frame: view.bounds)
          view.addSubview(containerView)
          
          containerView.backgroundColor = .systemBackground
          containerView.alpha = 0
          
          UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
          }
          
          let activityIndicator = UIActivityIndicatorView(style: .large)
          containerView.addSubview(activityIndicator)
          
          activityIndicator.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
              activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
          ])
          
        activityIndicator.startAnimating()
      }
      
      func dismissLoadingView() {
           DispatchQueue.main.async {
              self.containerView.removeFromSuperview()
              self.containerView = nil
           }
       }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
    }
    
    
    
}

//
//  Constants.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/5/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addButtonTapped(emote: Emoticon) {
        // showLoadingView()
        PersistenceManager.updateWith(favorite: emote, actionType: .add) { (error) in
            if error != nil {
                print(error!)
            }
            self.presentGFAlertOnMainThread(title: "Added emote to favories", message: "Successfully added emote to favorites! 🎉", buttonTitle: "Ok")
            PersistenceManager.retreiveFavorites { (emotes) in
                for emote in emotes {
                    print(emote.name)
                }
            }
        }
        
    }

}

extension UIView {
    // Variadic parameters
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

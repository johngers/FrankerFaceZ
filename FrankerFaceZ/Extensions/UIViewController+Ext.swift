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

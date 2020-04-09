//
//  ViewController.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/2/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var image = GFAvatarImageView(frame: .zero)
    
    var textField = GFTextField()
    let callToActionButton  = GFButton(backgroundColor: .systemPurple, title: "Get Emotes")
    var disclaimerLabel = GFBodyLabel(textAlignment: .center)
    var setID: Int = 0
    var streamerEmotes:[Emoticon] = []
    var channelID: String = ""
    
    //var isUsernameEntered:Bool { return !textField.text!.isEmpty }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(image)
        view.addSubview(textField)
        view.addSubview(callToActionButton)
        view.addSubview(disclaimerLabel)
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
        configureImageView()
        configureDisclaimerLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureImageView() {
           image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(named: "ffz.jpg")
           
           let topConstraintConstant: CGFloat = 50
           
           NSLayoutConstraint.activate([
               image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
               image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               image.heightAnchor.constraint(equalToConstant: 267),
               image.widthAnchor.constraint(equalToConstant: 267)
           ])
       }
    
    func configureTextField() {
           textField.delegate = self
        
        textField.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
//            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
//            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            callToActionButton.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
     func configureDisclaimerLabel() {
            disclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
            disclaimerLabel.text = "FrankerFaceZ is property of Dan Salvato LLC"

            NSLayoutConstraint.activate([
                disclaimerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -((self.tabBarController?.tabBar.frame.size.height)!)-12),
    //            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
    //            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                disclaimerLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
                disclaimerLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor),
                disclaimerLabel.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
        
    
    //Endpoint for twitch avatar link https://api.frankerfacez.com/v1/_user/xqcow
    
    
    
    
    @objc func pushFollowerListVC() {
        textField.resignFirstResponder()
        DispatchQueue.main.async {
            let destVC = EmoteListVC(channel: self.textField.text!)
            self.navigationController?.pushViewController(destVC, animated: true)
        }
       }
    
    @objc func openSettings() {
        DispatchQueue.main.async {
            let settings = SettingsVC()
            let navController = UINavigationController(rootViewController: settings)
            self.present(navController, animated: true)
            //self.navigationController?.pushViewController(settings, animated: true)
        }
    }

}

extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


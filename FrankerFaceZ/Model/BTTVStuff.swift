////
////  BTTVStuff.swift
////  FrankerFaceZ
////
////  Created by John Gers on 4/5/20.
////  Copyright © 2020 John Gers. All rights reserved.
////
//
//import Foundation
//
////// MARK: - Emotes
////struct BTTVEmotes: Codable {
////    let urlTemplate: String
////    let bots: [String]
////    let emotes: [BTTVEmote]
////}
////
////// MARK: - Emote
////struct BTTVEmote: Codable {
////    let id, channel, code: String
////    let imageType: ImageType
////}
////
////enum ImageType: String, Codable {
////    case gif = "gif"
////    case png = "png"
////}
//
////@objc func getBTTVEmotes() {
////         //textField.resignFirstResponder()
////         
////         let endpoint = "https://api.betterttv.net/2/channels/\(channelID)"
////                
////                guard let url = URL(string: endpoint) else {
////                    print("Invalid username")
////                    return
////                }
////                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
////                    if let _ = error {
////                        print("Error")
////                        return
////                    }
////                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
////                        print("Invalid response")
////                        return
////                    }
////                    guard let data = data else {
////                        print("Invalid data")
////                        return
////                    }
////                    do {
////                        let decoder = JSONDecoder()
////                         let followers = try decoder.decode(BTTVEmotes.self, from: data)
////                          print(followers.emotes.count)
////                      self.bttvEmotes = followers.emotes
////                       self.pushFollowerListVC()
////                      //print(self.bttvEmotes)
////                         //self.getBTTVEmoteArray()
////                         
////                    } catch {
////                        
////                     print(error.localizedDescription)
////                    }
////                }
////                task.resume()
////        
////     }
//
//    func setBTTV(emote: BTTVEmote) {
//           usernameLabel.text = emote.code
//           //print(emote.urls["4"] ?? nil)
//        let url = "https://cdn.betterttv.net/emote/\(emote.id)/2x"
////        if emote.imageType == .gif {
////            DispatchQueue.main.async {
////                self.avatarImageView.image = UIImage.gifImageWithURL(url)
////            }
////        } else {
//            downloadImageHelper(url: url)
//      //  }
//            
////               DispatchQueue.main.async {
////                   self.avatarImageView.image = UIImage(systemName: "person")
////               }
//       }

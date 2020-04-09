//
//  NetworkManager.swift
//  FrankerFaceZ
//
//  Created by John Gers on 4/5/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    static var displayName:String = ""
    var emotes:[Emoticon] = []
    let channelInfoURL = "https://api.frankerfacez.com/v1/room/"
    let setURL = "https://api.frankerfacez.com/v1/set/"
    let pageURL = "https://api.frankerfacez.com/v1/emoticons?q="
    let emoteURL = "https://api.frankerfacez.com/v1/emote/"
    let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    func getChannel(channelName:String, completed: @escaping([Emoticon]?) -> Void) {
        let endpoint = channelInfoURL + channelName
        
        guard let url = URL(string: endpoint) else {
            print("Invalid username")
            completed(self.emotes)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                print("Error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response")
                completed(self.emotes)
                return
            }
            guard let data = data else {
                print("Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: data)
                print(user.room.roomSet)
                NetworkManager.displayName = user.room.displayName
                self.getEmotes(channelID: String(user.room.roomSet), completed: { (emotes) in
                    completed(emotes)
                })
                
            } catch {
                
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getEmotes(channelID:String, completed: @escaping([Emoticon]?) -> Void) {
        
        let endpoint = setURL + channelID
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            print("Invalid username")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                print("Error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response")
                return
            }
            guard let data = data else {
                print("Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let emotes = try decoder.decode(Emote.self, from: data)
                NetworkManager.shared.emotes = emotes.emoteSet.emoticons
                completed(NetworkManager.shared.emotes)
            } catch {
                
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getPage(search:String, pageNumber:Int, completed: @escaping([Emoticon]?, Int) -> Void) {
        let endpoint = pageURL + search + "&page=\(pageNumber)" + "&sort=\(EmoteSearchVC.sortString)"
        
        guard let url = URL(string: endpoint) else {
            print("Invalid username")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                print("Error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response")
                return
            }
            guard let data = data else {
                print("Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let page = try decoder.decode(Page.self, from: data)
                completed(page.emoticons, page.pages)
            } catch {
                
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func getEmoteOwner(emote:Emoticon, completed: @escaping(EmoteOwner) -> Void) {
        let endpoint = emoteURL + String(emote.id)
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            print("Invalid username")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                print("Error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response")
                return
            }
            guard let data = data else {
                print("Invalid data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let emote = try decoder.decode(Eo.self, from: data)
                completed(emote.emote)
            } catch {
                
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

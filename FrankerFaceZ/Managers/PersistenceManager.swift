//
//  PersistenceManager.swift
//  GitHub Followers
//
//  Created by John Gers on 3/31/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func retreiveFavorites(completed: @escaping([Emoticon]) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else { //completed(.success([]))
            completed([])
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Emoticon].self, from: favoritesData)
            completed(favorites)
        } catch {
            //completed(.failure(.unableToFavorite))
            print(GFError.unableToFavorite)
        }
    }
    
    static func updateWith(favorite: Emoticon, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retreiveFavorites { (result) in
            var favorites = result
            switch actionType {
            case .add:
                guard !favorites.contains(favorite) else {
                    completed(.alreadyInFavorites)
                    return
                }
                
                favorites.append(favorite)
                completed(save(favorites: favorites))
                
            case .remove:
                favorites.removeAll { $0.id == favorite.id }
                completed(save(favorites: favorites))
            
            }
            
        }
    }
        
        static func save(favorites: [Emoticon]) -> GFError? {
            do {
                let encoder = JSONEncoder()
                let encodedFavorites = try encoder.encode(favorites)
                defaults.set(encodedFavorites, forKey: Keys.favorites)
                print("Added to user defaults")
                return nil
            } catch {
                return .unableToFavorite
            }
        }
}


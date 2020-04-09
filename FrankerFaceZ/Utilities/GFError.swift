//
//  GFError.swift
//  GitHub Followers
//
//  Created by John Gers on 3/29/20.
//  Copyright © 2020 John Gers. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case invalidFollowers   = "The data received was invalid."
    case unableToFavorite   = "There was an error favoriting this user."
    case alreadyInFavorites = "You've already favorites this user. You must really like them 😉"
}


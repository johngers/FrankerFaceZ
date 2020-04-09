// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    let room: Room
    //let sets: Sets
}

// MARK: - Room
struct Room: Codable {
    let id: Int
    let displayName, roomID: String
    let isGroup: Bool
    let roomSet, twitchID: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case displayName = "display_name"
        case roomID = "id"
        case isGroup = "is_group"
        case roomSet = "set"
        case twitchID = "twitch_id"
    }
}

// MARK: - Emote
struct Emote: Codable {
    let emoteSet: EmoteSet

    enum CodingKeys: String, CodingKey {
        case emoteSet = "set"
    }
}

// MARK: - Set
struct EmoteSet: Codable {
    let type: Int
    let emoticons: [Emoticon]
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case emoticons, id, title
    }
}

// MARK: - Emoticon
struct Emoticon: Codable, Equatable {
    let height: Int
    let hidden: Bool
    let id: Int
    let modifier: Bool
    let name: String
    let emoticonPublic: Bool
    let urls: [String: String]
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height, hidden, id, modifier, name
        case emoticonPublic = "public"
       // case usageCount = "usage_count"
        case urls, width
    }
}

struct Page: Codable {
    let pages, total: Int
    let emoticons: [Emoticon]

    enum CodingKeys: String, CodingKey {
        case pages = "_pages"
        case total = "_total"
        case emoticons
    }
}

// MARK: - Eo
struct Eo: Codable {
    let emote: EmoteOwner
}

// MARK: - Emote
struct EmoteOwner: Codable {
    let id: Int
    let name: String
    let owner: Owner
    let usageCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case usageCount = "usage_count"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int
    let displayName, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case displayName = "display_name"
        case name
    }
}

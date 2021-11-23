//
//  Model.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/24/21.
//

import UIKit
import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    let reputation: Int
    var name: String
    var aboutMe: String?
    var avatar: UIImage?
    let profileImageURL: URL?
    let userType: String
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case aboutMe = "about_me"
        case profileImageURL = "profile_image"
        case userType = "user_type"
        case reputation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userType = try container.decode(String.self, forKey: .userType)
        guard userType != "does_not_exist" else {
            id = 0
            reputation = 0
            name = ""
            profileImageURL = nil
            return
        }
        id = try container.decode(Int.self, forKey: .id)
        reputation = try container.decode(Int.self, forKey: .reputation)
        name = try container.decode(String.self, forKey: .name)
        profileImageURL = try container.decodeIfPresent(URL.self, forKey: .profileImageURL)
        aboutMe = try container.decodeIfPresent(String.self, forKey: .aboutMe)?.plainHtmlString
    }
}

struct Question: Identifiable, Equatable, Votable {
    let id: Int
    let viewCount: Int
    let answerCount: Int
    let title: String
    let body: String?
    let isAnswered: Bool
    let creationDate: Date
    let tags: [String]
    var owner: User?
    let comments: [Comment]?
    var answers: [Answer]?
    var score: Int
    var vote = Vote.none
}

extension Question: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case isAnswered = "is_answered"
        case creationDate = "creation_date"
        case title
        case body
        case score
        case owner
        case tags
        case comments
        case answers
        case vote
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        viewCount = try container.decode(Int.self, forKey: .viewCount)
        answerCount = try container.decode(Int.self, forKey: .answerCount)
        title = try container.decode(String.self, forKey: .title).plainHtmlString
        isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        tags = try container.decode([String].self, forKey: .tags)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        comments = try container.decodeIfPresent([Comment].self, forKey: .comments)
        answers = try container.decodeIfPresent([Answer].self, forKey: .answers)
        vote = try container.decodeIfPresent(Vote.self, forKey: .vote) ?? .none
    }
}

struct Answer: Identifiable, Equatable, Votable {
    let id: Int
    let body: String?
    let creationDate: Date
    let isAccepted: Bool
    var owner: User?
    var score: Int
    var vote = Vote.none
}

extension Answer: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "answer_id"
        case creationDate = "creation_date"
        case isAccepted = "is_accepted"
        case body
        case score
        case owner
        case vote
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        isAccepted = try container.decode(Bool.self, forKey: .isAccepted)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        vote = try container.decodeIfPresent(Vote.self, forKey: .vote) ?? .none
    }
}

struct Comment: Identifiable, Equatable {
    let id: Int
    let body: String?
    let owner: User?
}

extension Comment: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case body
        case owner
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        body = try container.decodeIfPresent(String.self, forKey: .body)?.plainHtmlString
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
    }
}

enum Vote: Int, Codable {
    case none = 0
    case up = 1
    case down = -1
}

protocol Votable {
    var vote: Vote { get set }
    var score: Int { get set }
}

extension Votable {
    mutating func upvote() {
        cast(vote: .up)
        
    }
    mutating func downvote() {
        cast(vote: .down)
    }
    mutating func unvote() {
        score -= vote.rawValue
        vote = .none
    }
}

private extension Votable {
    mutating func cast(vote: Vote) {
        guard self.vote != vote else { return }
        unvote()
        score += vote.rawValue
        self.vote = vote
    }
    
}

struct Tag: Identifiable, Codable {
    let count: Int
    let name: String
    var excerpt: String?
   var questions: [Question]?
    
    var id: String { name }
    
}

extension Tag {
    struct Excerpt: Codable {
        let text: String
        
        enum CodingKeys: String, CodingKey {
            case text = "excerpt"
        }
    }
}
    

struct Wrapper<ModelType: Decodable>: Decodable {
    let items: [ModelType]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

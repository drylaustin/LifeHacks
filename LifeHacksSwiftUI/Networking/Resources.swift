//
//  Resources.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/15/21.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var path: String { get }
    var parameters: [String: String] { get }
}

extension APIResource {
    var url: URL {
            URL(string: "https://api.stackexchange.com/2.2")!
                .appendingPathComponent(path)
                .appendingParameters(parameters)
                .appendingParameters(["order": "desc", "pagesize": "10", "site": "lifehacks"])
        }
}

struct UsersResource: APIResource {
    typealias ModelType = User
    var id: Int?
    
    var path: String {
        guard let id = id else { return "/users" }
        return "/users/\(id)"
    }
    var parameters: [String : String] {
        if id == nil {
            return ["sort": "reputation"]
        } else {
            return ["filter": "!9YdnSA078"]
        }
    }
}

struct QuestionsResource: APIResource {
    typealias ModelType = Question
    var id: Int?
    var tag: String?
    
    var path: String {
        guard let id = id else { return "/questions" }
        return "/questions/\(id)"
    }
    
    var parameters: [String : String] {
        var parameters: [String: String]
        if id == nil {
            parameters = ["sort": "votes"]
        } else {
            parameters = ["filter": "!3zl2.BHmiROa9.Phi"]
        }
        if let tag = tag {
            parameters["tagged"] = tag
        }
        return parameters
    }
}

struct TagsResource: APIResource {
    typealias ModelType = Tag
    let path = "/tags"
    let parameters = ["sort" : "popular"]
    
}

struct TagWikiResource: APIResource {
    typealias ModelType = Tag.Excerpt
    let parameters: [String : String] = [:]
    let name: String
    
    var path: String { "/tags/\(name)/wikis" }
}

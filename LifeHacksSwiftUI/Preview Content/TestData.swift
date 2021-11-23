//
//  TestData.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/26/21.
//

import Foundation

struct TestData {
    static let shortText = "In the tumultuous business of cutting-in and attending to a whale, there is much running backwards and forwards among the crew."
    static let longText = "So strongly and metaphysically did I conceive of my situation then, that while earnestly watching his motions, I seemed distinctly to perceive that my own individuality was now merged in a joint stock company of two; that my free will had received a mortal wound; and that another's mistake or misfortune might plunge innocent me into unmerited disaster and death."
    static let tags = ["monkey", "rope", "found", "all", "whalers"]
    static let user = User(id: 0, reputation: 1234, name: "Betty Vasquez", aboutMe: longText, avatar: #imageLiteral(resourceName: "icons8-team-FcLyt7lW5wg-unsplash"), profileImageURL: URL(string: "example.com")!, userType: "")
    static let otherUser = User(id: 1, reputation: 986, name: "Martin Abasto", aboutMe: longText, avatar: #imageLiteral(resourceName: "Other"), profileImageURL: URL(string: "example.com")!, userType: "")

    static let questions: [Question] = loadFile(named: "Questions")
    
    static let users: [User] = {
        var users: [User] = loadFile(named: "Users")
        for index in users.indices {
            users[index].avatar = #imageLiteral(resourceName: "laurence-cruz-P7yvmajPvkM-unsplash-4")
        }
        return users
    }()
    
    static let topTags: [Tag] = {
        var tags: [Tag] = loadFile(named: "Tags")
        for index in tags.indices {
            tags[index].excerpt = shortText
            tags[index].questions = questions
        }
        return tags
    }()
    
    static var question: Question { questions.first! }
    static var comment: Comment { questions.first!.comments!.first! }
    static var answer: Answer { questions.first!.answers!.first! }
    static var tag: Tag { topTags.first! }
        
    static func loadFile<ModelType: Decodable>(named name: String) -> [ModelType]  {
        let url = Bundle.main.url(forResource: name, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let wrapper = try! JSONDecoder().decode(Wrapper<ModelType>.self, from: data)
        return wrapper.items
    }
}



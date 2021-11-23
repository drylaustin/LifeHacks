//
//  StateController.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/8/21.
//

import Foundation
import SwiftUI

class StateController: ObservableObject {
    @Published private(set) var mainUser = TestData.user
    @Published var tags = TestData.topTags
    @Published var users = TestData.users
    
    
    @Published var topQuestions: [Question] {
        didSet { storageController.save(topQuestions: topQuestions) }
    }

    
    private let storageController = StorageController()
    
    subscript(questionID: Int) -> Question {
        get { topQuestions[index(for: questionID)] }
        set { topQuestions[index(for: questionID)] = newValue }
    }
    init() {
            topQuestions = storageController.fetchTopQuestions() ?? []
            mainUser = storageController.fetchUser() ?? TestData.user
        }
    
    
    func save(name: String, aboutMe: String, avatar: UIImage) {
        mainUser.name = name
        mainUser.aboutMe = aboutMe
        mainUser.avatar = avatar
        storageController.save(user: mainUser)
    }
}

private extension StateController {
    func index(for questionID: Int) -> Int {
        topQuestions.firstIndex(where: { $0.id == questionID })!
    }
}

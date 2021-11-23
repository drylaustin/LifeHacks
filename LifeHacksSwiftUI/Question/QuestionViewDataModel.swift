//
//  QuestionViewDataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import Foundation
import UIKit

extension QuestionView {
    class DataModel: ObservableObject, LifeHacksSwiftUI.DataModel {
        @Published var question: Question
        @Published var isLoading = false
        
        private var questionRequest: APIRequest<QuestionsResource>?
        internal var avatarRequests: [ImageRequest] = []
        
        init(question: Question) {
            self.question = question
        }
        
        func loadQuestion() {
            guard !isLoading else { return }
            isLoading = true
            let resource = QuestionsResource(id: question.id)
            let request = APIRequest(resource: resource)
            self.questionRequest = request
            request.execute { [weak self] questions in
                self?.isLoading = false
                guard let question = questions?.first else { return }
                self?.question = question
                self?.loadOwnerAvatar()
                self?.loadAnswerAvatars()
                
            }
        }
    }
}

private extension QuestionView.DataModel {
 
    
    func loadOwnerAvatar() {
        guard let owner = question.owner else { return }
        loadAvatar(for: owner) { [weak self] avatar in
            self?.question.owner?.avatar = avatar
        }
    }
    
    func loadAnswerAvatars() {
        guard let answers = question.answers else { return }
        for (index, answer) in answers.enumerated() {
            guard let owner = answer.owner else { continue }
            loadAvatar(for: owner) { [weak self] avatar in
                self?.question.answers?[index].owner?.avatar = avatar
            }
        }
    }
}

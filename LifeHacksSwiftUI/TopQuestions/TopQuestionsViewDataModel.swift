//
//  TopQuestionsViewDataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/15/21.
//

import Foundation

extension TopQuestionsView {
    class DataModel: ObservableObject {
        @Published var questions: [Question] = []
        @Published var isLoading = false
        
        private var request: APIRequest<QuestionsResource>?
        
        func fetchTopQuestions() {
            guard !isLoading else { return }
            isLoading = true
            let resource = QuestionsResource()
            let request = APIRequest(resource: resource)
            self.request = request
            request.execute { [weak self] questions in
                self?.questions = questions ?? []
                self?.isLoading = false
            }
        }
    }
}

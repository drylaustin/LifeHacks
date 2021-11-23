//
//  TopTagsViewDataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import Foundation

extension TopTagsView {
    class DataModel: ObservableObject {
        @Published var tags: [Tag] = []
        @Published var isLoading = false
        
        private var tagsRequest: APIRequest<TagsResource>?
        private var excerptRequests: [APIRequest<TagWikiResource>] = []
        private var questionsRequests: [APIRequest<QuestionsResource>] = []
        
        func loadTags() {
            guard !isLoading else { return }
            isLoading = true
            let request = APIRequest(resource: TagsResource())
            tagsRequest = request
            request.execute { [weak self] tags in
                guard let tags = tags else { return }
                self?.tags = tags
                self?.isLoading = false
                for tag in tags {
                    self?.loadExcerpt(for: tag)
                    self?.loadQuestions(for: tag)
                }
            }
        }
    }
}
 
private extension TopTagsView.DataModel {
    func loadExcerpt(for tag: Tag) {
        let resource = TagWikiResource(name: tag.name)
        let request = APIRequest(resource: resource)
        excerptRequests.append(request)
        request.execute { [weak self] excerpts in
            self?.excerptRequests.removeAll(where: { $0 === request })
            guard let excerpt = excerpts?.first else { return }
            let index = self?.tags.firstIndex(where: { $0.name == tag.name })
            self?.tags[index!].excerpt = excerpt.text
        }
    }
    
    func loadQuestions(for tag: Tag) {
        let resource = QuestionsResource(tag: tag.name)
        let request = APIRequest(resource: resource)
        questionsRequests.append(request)
        request.execute { [weak self] questions in
            self?.questionsRequests.removeAll(where: { $0 === request })
            guard let questions = questions else { return }
            let index = self?.tags.firstIndex(where: { $0.name == tag.name })
            self?.tags[index!].questions = questions
        }
    }
}

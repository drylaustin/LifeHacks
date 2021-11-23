//
//  TopQuestionsView.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/30/21.
//

import SwiftUI

struct TopQuestionsView: View {
    @EnvironmentObject private var stateController: StateController
    @StateObject private var dataModel = DataModel()
    
    var body: some View {
        Content(questions: $stateController.topQuestions, isLoading: dataModel.isLoading)
            .environment(\.navigationMap, NavigationMap(destinationForQuestion: { QuestionView(question: $0) }))
            .onAppear(perform: dataModel.fetchTopQuestions)
            .onChange(of: dataModel.questions) { questions in
                            stateController.topQuestions = questions
                        }
    }
}


fileprivate typealias Content = TopQuestionsView.Content

extension TopQuestionsView {
    struct Content: View {
        @Binding var questions : [Question]
        var isLoading: Bool = false
        
        @Environment(\.navigationMap) private var navigationMap
        @SceneStorage("TopQuestionsView.Content.SelectedQuestionID") private var selectedQuestionID: Question.ID?
        
        var body: some View {
            List {
                LoadingIndicator(isLoading: isLoading)
                ForEach(questions) { question in
                    NavigationLink(destination: navigationMap.destinationForQuestion?(question),
                                   tag: question.id,
                                   selection: $selectedQuestionID) { QuestionRow(question: question)
                        
                    }
                }
                .onDelete(perform: deleteItems(atOffsets:))
                .onMove(perform: move(fromOffsets:toOffset:))
            }
            .navigationTitle("Top Questions")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
        }
        
        func deleteItems(atOffsets offsets: IndexSet) {
            questions.remove(atOffsets: offsets)
        }
        func move(fromOffsets source: IndexSet, toOffset destination: Int) {
            questions.move(fromOffsets: source, toOffset: destination)
        }
        
    }
}



struct TopQuestionsView_Previews: PreviewProvider {
    //    typealias Counter = QuestionRow.Counter
    //    typealias Details = QuestionRow.Details
    
    
    
    static var previews: some View {
        NavigationView {
            Content(questions: .constant(TestData.questions))
            
        }
        .fullScreenPreviews()
    }
}

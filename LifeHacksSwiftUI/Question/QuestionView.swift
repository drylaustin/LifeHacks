//
//  QuestionView.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/25/21.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject private var stateController: StateController
    @StateObject private var dataModel: DataModel
    
    init(question: Question) {
        let dataModel = DataModel(question: question)
        _dataModel = StateObject(wrappedValue: dataModel)
    }
    
    var body: some View {
        Content(question: $stateController[dataModel.question.id], isLoading: dataModel.isLoading)
            .environment(\.navigationMap, NavigationMap(destinationForUser: destination(for:)))
            .onAppear(perform: dataModel.loadQuestion)
            .onChange(of: dataModel.question) { question in
                stateController[dataModel.question.id] = question
            }
    }
}

private extension QuestionView {
    func index(for question: Question) -> Int {
        stateController.topQuestions.firstIndex(where: { $0.id == question.id }) ?? 0
    }
    
    func destination(for user: User) -> ProfileView {
        ProfileView(user: user, isMainUser: user.id == stateController.mainUser.id)
    }
}

fileprivate typealias Content = QuestionView.Content

extension QuestionView {
    struct Content : View {
        @Binding var question: Question
        var isLoading = false
        
        var body: some View {
            ScrollViewReader { scrolling in
                ScrollView {
                    LoadingIndicator(isLoading: isLoading)
                    LazyVStack {
                        QuestionDetails(question: $question, jumpToAnswer: { jumpToAnswer(with: scrolling) })
                            .padding(.horizontal, 20.0)
                        if let comments = question.comments {
                            PaddedDivider()
                            Comments(comments: comments)
                        }
                        if let answers = question.answers {
                            PaddedDivider()
                            ForEach(answers.indices) { index in
                                AnswerDetails(answer: Binding {
                                    answers[index]
                                } set: {
                                    question.answers?[index] = $0
                                })
                                    .padding(.horizontal, 20.0)
                                    .padding(.vertical, 24.0)
                                    .id(question.answers![index].id)
                                PaddedDivider()
                            }
                        }
                    }
                }
                .navigationTitle("Question")
            }
        }
    }
}

private extension Content {
    func jumpToAnswer(with scrolling: ScrollViewProxy) {
        guard let acceptedAnswer = question.answers?.first(where: { $0.isAccepted }) else { return }
        withAnimation {
            scrolling.scrollTo(acceptedAnswer.id, anchor: .top)
        }
    }
}

fileprivate typealias PaddedDivider = QuestionView.PaddedDivider

extension QuestionView {
    struct PaddedDivider: View {
        var body: some View {
            Divider()
                .padding(.leading, 20.0)
        }
    }
}


//private extension QuestionView {
//    var tagsString: String {
//        var result = tags.first ?? ""
//        for tag in tags.dropFirst() {
//            result.append("," + tag)
//        }
//        return result
//    }
//}

extension QuestionView {
    struct Comments: View {
        let comments: [LifeHacksSwiftUI.Comment]
        
        var body: some View {
            GeometryReader { geometry in
                //                ScrollView(.horizontal, showsIndicators: false)
                TabView{
                    //                    LazyHStack(alignment: .top)
                    //                    {
                    ForEach(comments) { comment in
                        Comment(comment: comment)
                            .frame(width: geometry.size.width - 40.0)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                //                    .padding(.horizontal)
                
            }
            .frame(height: 174.0)
            .padding(.vertical)
        }
    }
}

fileprivate typealias Comments = QuestionView.Comments

extension Comments {
    struct Comment: View {
        let comment: LifeHacksSwiftUI.Comment
        
        @Environment(\.navigationMap) private var navigationMap
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(comment.body ?? "")
                    .lineLimit(5)
                if let owner = comment.owner { NavigationLink(destination: navigationMap.destinationForUser?(owner)) {
                    Text(owner.name)
                        .foregroundColor(.accentColor)
                }
                }
            }
            .font(.subheadline)
            .padding(24.0)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(6.0)
        }
    }
}

fileprivate typealias Owner = QuestionView.Owner
extension QuestionView {
    struct Owner: View {
        internal init(name: String, reputation: Int, avatar: UIImage) {
            self.name = name
            self.reputation = reputation
            self.avatar = avatar
        }
        
        let name: String
        let reputation: Int
        let avatar: UIImage
        
        var body: some View{
            HStack {
                RoundImage(image: avatar)
                    .frame(width: 48.0, height: 48.0)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(name)
                        .font(.headline)
                    Text("\(reputation.formatted) reputation")
                        .font(.caption)
                }
            }
            .padding(16)
            
        }
        
    }
}

extension Owner {
    init(user: User) {
        name = user.name
        reputation = user.reputation
        avatar = user.avatar ?? UIImage()
    }
}


struct QuestionView_Previews: PreviewProvider {
  
    typealias Comments = QuestionView.Comments
    typealias Comment = Comments.Comment
    
    static let question = TestData.question
    static let user = TestData.user
    static let comment = TestData.comment
    
    static var previews: some View {
        Group {
            NavigationView {
                Content(question: .constant(question))
            }
            .fullScreenPreviews(showAll: true)
            Owner(user: user)
                .style(.primary)
                .previewWithName(String.name(for: Owner.self))
            Comments(comments: question.comments!)
                .namedPreview()
            Comment(comment: comment)
                .namedPreview()
        }
    }
    
}

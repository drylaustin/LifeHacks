//
//  ProfileView.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/6/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var isEditing = false
    @EnvironmentObject private var settingsController: SettingsController
    @EnvironmentObject private var stateController: StateController
    @StateObject private var dataModel: DataModel
    
    init(user: User, isMainUser: Bool = false) {
        let model = DataModel(user: user, isMainUser: isMainUser)
        _dataModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        Content(user: user, isMainUser: dataModel.isMainUser, editAction: { isEditing = true })
            .onAppear(perform: dataModel.loadUser)
            .fullScreenCover(isPresented: $isEditing) {
                NavigationView {
                    EditProfileView()
                }
                .accentColor(settingsController.theme.accentColor)
            }
    }
}
private extension ProfileView {
    var user: User {
        dataModel.isMainUser
        ? stateController.mainUser
        : dataModel.user
    }
}


fileprivate typealias Content = ProfileView.Content

extension ProfileView {
    struct Content: View {
        let user: User
        let isMainUser: Bool
        let editAction: () -> Void
        
        var body: some View {
            ScrollView {
                Header (
                    avatar: user.avatar ?? UIImage(),
                    name: user.name,
                    reputation: user.reputation,
                    isMainUser: isMainUser)
                Text(user.aboutMe ?? "")
                    .padding(.top, 16.0)
                    .padding(.horizontal, 20.0)
            }
            .navigationTitle(Text("Profile"))
            .toolbar {
                ToolbarItem(placement: .primaryAction, content: { editButton })
            }
            
            
        }
        
    }
    
}
private extension Content {
    var editButton: Button<Text>? {
        guard isMainUser else { return nil }
        return Button(action: editAction) {
            Text("Edit")
        }
    }
}



fileprivate typealias Header = ProfileView.Header

extension ProfileView {
    struct Header: View {
        let avatar: UIImage
        let name: String
        let reputation: Int
        var isMainUser: Bool = false
        
        var body: some View {
            VStack(spacing: 4.0) {
                RoundImage(image: avatar)
                    .frame(width: 144, height: 144)
                Text(name)
                    .font(.title)
                    .bold()
                    .padding(.top, 12.0)
                Text("\(reputation.formatted) reputation")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 24)
            .style(isMainUser ? .primary : .secondary, rounded: false)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static let user = TestData.user
    static let otherUser = TestData.otherUser
    
    static var previews: some View {
        Group {
            NavigationView {
                Content(user: user, isMainUser: true, editAction: {})
            }
            .fullScreenPreviews()
            VStack {
                Header(avatar: otherUser.avatar!, name: otherUser.name, reputation: otherUser.reputation)
                Header(avatar: user.avatar!, name: user.name, reputation: user.reputation, isMainUser: true)
            }
            .previewWithName(.name(for: Header.self))
        }
        
    }
    
}

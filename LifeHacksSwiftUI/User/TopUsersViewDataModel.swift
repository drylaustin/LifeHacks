//
//  TopUsersViewDataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import Foundation

extension TopUsersView {
    class DataModel: ObservableObject, LifeHacksSwiftUI.DataModel {
        @Published var users: [User] = []
        @Published var isLoading = false
        
        private var usersRequest: APIRequest<UsersResource>?
        internal var avatarRequests: [ImageRequest] = []
        
        func loadUsers() {
            guard !isLoading else { return }
            isLoading = true
            let request = APIRequest(resource: UsersResource())
            usersRequest = request
            request.execute { [weak self] users in
                self?.isLoading = false
                guard let users = users else { return }
                self?.users = users
                self?.loadAvatars()
            }
        }
    }
}
 
extension TopUsersView.DataModel {
    func loadAvatars() {
        for (index, user) in users.enumerated() {
            loadAvatar(for: user) { [weak self] avatar in
                self?.users[index].avatar = avatar
            }
        }
    }
}

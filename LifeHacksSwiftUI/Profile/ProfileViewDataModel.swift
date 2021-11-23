//
//  ProfileViewDataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import Foundation
import UIKit

extension ProfileView {
    class DataModel: ObservableObject, LifeHacksSwiftUI.DataModel {
        let isMainUser: Bool
        
        @Published var user: User
        @Published var isLoading = false
        
        internal var avatarRequests: [ImageRequest] = []
        
        init(user: User, isMainUser: Bool) {
            self.user = user
            self.isMainUser = isMainUser
        }
        
        func loadUser() {
            guard !isMainUser else { return }
            guard !isLoading else { return }
            isLoading = true
            let resource = UsersResource(id: user.id)
            let request = APIRequest(resource: resource)
            request.execute { [weak self] users in
                self?.isLoading = false
                guard let user = users?.first else { return }
                self?.user.aboutMe = user.aboutMe
                self?.loadAvatar()
            }
        }
    }
}
 
private extension ProfileView.DataModel {
    func loadAvatar() {
        loadAvatar(for: user) { [weak self] avatar in
            self?.user.avatar = avatar
        }
    }
}

//
//  DataModel.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import Foundation
import UIKit

protocol DataModel: AnyObject {
    var avatarRequests: [ImageRequest] { get set }
}

extension DataModel {
    func loadAvatar(for user: User, withCompletion completion: @escaping (UIImage?) -> Void) {
        guard let url = user.profileImageURL else { return }
        let request = ImageRequest(url: url)
        self.avatarRequests.append(request)
        request.execute { [weak self] image in
            completion(image)
            self?.avatarRequests.removeAll(where: { $0 === request })
        }
    }
}

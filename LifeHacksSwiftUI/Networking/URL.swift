//
//  URL.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/14/21.
//

import Foundation

extension URL {
    func appendingParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        for key in parameters.keys {
            queryItems.append(URLQueryItem(name: key, value: parameters[key]))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

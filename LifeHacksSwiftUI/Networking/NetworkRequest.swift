//
//  NetworkRequest.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/15/21.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    var url: URL { get }
    func decode(_ data: Data) -> ModelType?
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (ModelType?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    var url: URL {
        return resource.url
    }
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return wrapper?.items
    }
}

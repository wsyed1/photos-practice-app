//
//  Endpoint.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
}

protocol Endpoint {
    var request: URLRequest? { get}
    var httpMethod: HttpMethod? { get }
    var queryItems: [URLQueryItem] { get }
    var messageBodyDictionary: [String: Any]? { get }
}

extension Endpoint {
    func request() -> URLRequest? {
        guard let url = request?.url else { return nil }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let cannonicalUrl = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: cannonicalUrl)
        
        guard let httpMethod = httpMethod else {
            return nil
        }
        
        request.httpMethod = httpMethod.rawValue
        
        switch httpMethod {
        case .put, .post:
            guard let postParameters = messageBodyDictionary,
                let httpBody =  try? JSONSerialization.data(withJSONObject: postParameters,
                                                            options: JSONSerialization.WritingOptions.prettyPrinted) else {
                    assertionFailure("Failed to parse body paramters")
                    return nil
            }
            request.httpBody = httpBody
        case .get, .delete:
            break
        }
        
        return request
    }
}

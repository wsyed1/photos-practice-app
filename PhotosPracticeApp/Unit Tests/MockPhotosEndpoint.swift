//
//  MockPhotosEndpoint.swift
//  PhotosPracticeAppTests
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

@testable import PhotosPracticeApp
import XCTest

final class MockPhotosEndpoint: Endpoint {
    private var fileUrl: URL
    
    init(_ fileUrl: URL) {
        self.fileUrl = fileUrl
    }
    var request: URLRequest? {
        return URLRequest(url: fileUrl)
    }
    
    var httpMethod: HttpMethod? = HttpMethod.get
    
    var _queryItems: [URLQueryItem] = []
    var queryItems: [URLQueryItem] {
            var urlQueryItems: [URLQueryItem] = []
            urlQueryItems.append(URLQueryItem(name: "key", value: "8630898-e092bf16cb1dd9ff6a483dabf"))
            urlQueryItems.append(URLQueryItem(name: "order", value: "latest"))
            urlQueryItems.append(URLQueryItem(name: "page", value: "1"))
            urlQueryItems.append(URLQueryItem(name: "per_page", value: "50"))

            return urlQueryItems
    }
    
    var messageBodyDictionary: [String : Any]?
}

//
//  PhotosEndpoint.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

class PhotosEndpoint: Endpoint {
    private let urlStr: String = "https://pixabay.com/api/"
    
    var request: URLRequest? {
        guard let url = URL(string: urlStr) else {
                return nil
            }
            
        return URLRequest(url: url)
    }
    
    var httpMethod: HttpMethod? = HttpMethod.get
    
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

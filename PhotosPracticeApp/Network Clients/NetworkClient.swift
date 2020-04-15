//
//  NetworkClient.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

typealias NetworkCallCompletion = (Data?, URLResponse?, Error?) -> Void

class NetworkClient {
    func request(_ endpoint: Endpoint, networkCallCompletion: @escaping NetworkCallCompletion) {
        guard let request = endpoint.request() else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               networkCallCompletion(data, response,error)
        }
        
        task.resume()
        
    }
}

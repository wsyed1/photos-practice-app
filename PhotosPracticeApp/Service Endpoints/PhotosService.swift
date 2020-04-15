//
//  PhotosService.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

class PhotosService {
    enum PhotosServiceResultType {
        case success(hits: [Hit])
        case fail(error: String)
    }
    
    private var photosEndpoint: Endpoint
    
    init(_ photosEndpoint: Endpoint) {
        self.photosEndpoint = photosEndpoint
    }
    
    func fetchPhotos(_ completion: @escaping (PhotosServiceResultType) -> Void) {
        let networkClient = NetworkClient()
        networkClient.request(photosEndpoint) { (data, response, error) in
            guard error == nil else {
                completion(.fail(error: error!.localizedDescription))
                
                return
            }
            
            guard let data = data else {
                completion(.fail(error: "Invalid Data returned"))
                
                return
            }
            
            guard let photoBrowserModel = try? JSONDecoder().decode(PhotoBrowserModel.self, from: data) else {
                completion(.fail(error: "Unable to parse data into PhotoBrowserModel"))
                
                return
            }
            
            completion(.success(hits: photoBrowserModel.hits ?? []))
        }
    }
}

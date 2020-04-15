//
//  PhotoBrowserModel.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

// MARK: - PhotoBrowserModel
struct PhotoBrowserModel: Codable {
    let totalHits: Int?
    let hits: [Hit]?
    let total: Int?
}

// MARK: - Hit
struct Hit: Codable {
    let largeImageURL: String?
    let likes: Int?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL
        case likes
        case userID = "user_id"
    }
}

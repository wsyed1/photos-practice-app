//
//  PhotoViewModel.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation

struct PhotoCellModel {
    var url: String
    var likes: String
    var user: String
}

struct PhotoViewModel {
    private let hits: [Hit]
    
    init(_ hits: [Hit]) {
        self.hits = hits
    }
    
    func getNumberOfRows() -> Int {
        return hits.count
    }
    
    func modelFor(_ row: Int) -> PhotoCellModel {
        let hit = hits[row]
        let url = hit.largeImageURL ?? ""
        let likesString: String
        let user: String
        
        if let likes = hit.likes {
            likesString = "\(likes) likes"
        } else {
            likesString = ""
        }
        
        if let userID = hit.userID {
            user = String(userID)
        } else {
            user = ""
        }
        
        return PhotoCellModel(url: url, likes: likesString, user: user)
    }
}

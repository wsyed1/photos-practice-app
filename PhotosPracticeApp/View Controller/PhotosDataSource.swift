//
//  PhotosDataSource.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import UIKit

final class PhotoDataSource: NSObject {
    private var parentVC: PhotosViewController?
    private var photoCache = NSCache<NSString, UIImage>()
    
    init(_ parentVC: PhotosViewController) {
        self.parentVC = parentVC
    }
}

extension PhotoDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentVC?.viewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath)
        guard let cell =  dequeueCell as? PhotoTableViewCell,
            let viewModel = parentVC?.viewModel else {
                return UITableViewCell()
        }
        
        let currentModel = viewModel.modelFor(indexPath.row)
        let currentNsUrlStr = NSString(string: currentModel.url)
        
        // check if the photo is present in the cache
        if let cachedPhoto = photoCache.object(forKey: currentNsUrlStr) {
            cell.configure(cachedPhoto, likes: currentModel.likes, user: currentModel.user)
        } else {
            configure(cell, currentModel: currentModel)
        }

        
        return cell
    }
}

// Cell Configure
private extension PhotoDataSource {
    func configure(_ cell: PhotoTableViewCell, currentModel: PhotoCellModel) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.downloadImage(for: currentModel.url, likes: currentModel.likes, userName: currentModel.user, completion: { (downloadedPhoto, downloadedUrl, downloadedLikes, downloadedUser)  in
                let downloadedNsUrlStr = NSString(string: downloadedUrl)
                // appending downloaded photo to photoCache
                
                self.photoCache.setObject(downloadedPhoto, forKey: downloadedNsUrlStr)
                
                DispatchQueue.main.async {
                    if currentModel.url == downloadedUrl {
                        cell.configure(downloadedPhoto, likes: downloadedLikes, user: downloadedUser)
                    }
                }
            })
        }
    }
    
    func downloadImage(for urlStr: String, likes: String, userName: String, completion: @escaping (UIImage, String, String, String) -> Void) {
        guard let url = URL(string: urlStr) else {
            completion(#imageLiteral(resourceName: "PlaceHolder.png"), urlStr, likes, userName)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let downloadedPhoto = UIImage(data: data) else {
                completion(#imageLiteral(resourceName: "PlaceHolder.png"), urlStr, likes, userName)
                return
            }
            
            completion(downloadedPhoto, urlStr, likes, userName)
            
        }
        
        task.resume()
    }
}

//
//  PhotosDelegate.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import UIKit

final class PhotosDelegate: NSObject {
    private weak var parentVC: PhotosViewController?
    
    init(_ parentVC: PhotosViewController) {
        self.parentVC = parentVC
    }
}

extension PhotosDelegate: UITableViewDelegate {}

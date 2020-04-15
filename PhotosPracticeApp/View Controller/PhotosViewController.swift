//
//  PhotosViewController.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: PhotoDataSource?
    private var delegate: PhotosDelegate?
    
    var viewModel: PhotoViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchPhotos()
    }
}

private extension PhotosViewController {
    func setUpTableView() {
        dataSource = PhotoDataSource(self)
        delegate = PhotosDelegate(self)
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    func fetchPhotos() {
        let photosEndpoint = PhotosEndpoint()
        let photoService = PhotosService(photosEndpoint)
        photoService.fetchPhotos { (result) in
            switch result {
            case let .fail(error):
                assertionFailure(error)
            case let .success(hits):
                self.viewModel = PhotoViewModel(hits)
            }
        }
    }
}

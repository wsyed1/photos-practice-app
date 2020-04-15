//
//  PhotosViewModelUnitTests.swift
//  PhotosPracticeAppTests
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

@testable import PhotosPracticeApp
import XCTest

final class PhotosViewModelUnitTests: XCTestCase {
    var sut: PhotoViewModel!
    private var successFulRowModel = PhotoCellModel(
    url: "https://pixabay.com/get/52e5dd414e55a414f6da8c7dda793f78163fd6ec5b4c704c722d79d4944ac758_1280.jpg",
    likes: "0 likes",
    user: "2233926"
    )
    
    
    private var photoBrowserModel: PhotoBrowserModel {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: "MockPhotosResponse", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let photoBrowserModel = try? JSONDecoder().decode(PhotoBrowserModel.self, from: data) else {
                fatalError()
        }
        
        return photoBrowserModel
    }
    
    override func setUp() {
        sut = PhotoViewModel(photoBrowserModel.hits ?? [])
    }

    override func tearDown() {
    }

    func testView_Model() {
        XCTAssertTrue(photoBrowserModel.hits!.count == 50)
        XCTAssertTrue(sut.modelFor(0).url == successFulRowModel.url)
        XCTAssertTrue(sut.modelFor(0).likes == successFulRowModel.likes)
        XCTAssertTrue(sut.modelFor(0).user == successFulRowModel.user)
    }
}

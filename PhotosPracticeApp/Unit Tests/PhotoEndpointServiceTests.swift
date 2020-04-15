//
//  PhotoEndpointTest.swift
//  PhotosPracticeAppTests
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

@testable import PhotosPracticeApp
import XCTest

final class PhotoEndpointTest: XCTestCase {
    var successfulMockPhotosEndpoint: MockPhotosEndpoint!
    var failureMockPhotosEndpoint: MockPhotosEndpoint!
    var endpoint: Endpoint!
    
    var sut: PhotosService!
    
    private var url: URL {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: "MockPhotosResponse", withExtension: "json") else {
            fatalError()
        }
        
        return url
    }
    
    private var urlQueryItems: [URLQueryItem] {
        var urlQueryItems: [URLQueryItem] = []
        urlQueryItems.append(URLQueryItem(name: "key", value: "8630898-e092bf16cb1dd9ff6a483dabf"))
        urlQueryItems.append(URLQueryItem(name: "order", value: "latest"))
        urlQueryItems.append(URLQueryItem(name: "page", value: "1"))
        urlQueryItems.append(URLQueryItem(name: "per_page", value: "50"))
        
        return urlQueryItems
    }
    
    
    override func setUp() {
        successfulMockPhotosEndpoint = MockPhotosEndpoint(url)
//        failureMockPhotosEndpoint = MockPhotosEndpoint(URL(string: "")!)
    }

    override func tearDown() {
        sut = nil
        successfulMockPhotosEndpoint = nil
        failureMockPhotosEndpoint = nil
    }
    

    func test_Valid_Photos_Enpoint() {
        sut = PhotosService(successfulMockPhotosEndpoint)
        
        sut.fetchPhotos { (resultType) in
            switch resultType {
            case let .success(hits):
                XCTAssertTrue(hits.count == 50)
                XCTAssertTrue(hits[0].largeImageURL == "https://pixabay.com/get/52e5dd414e55a414f6da8c7dda793f78163fd6ec5b4c704c722d79d4944ac758_1280.jpg")
                XCTAssertTrue(hits[0].userID == 2233926)
                XCTAssertTrue(hits[0].likes == 0)
            case let .fail(error):
                XCTFail("Unexpected failed with error = \(error.description)")
            }
        }
    }
    
//    func test_InValid_Photos_Enpoint() {
//        sut = PhotosService(failureMockPhotosEndpoint)
//
//        sut.fetchPhotos { (resultType) in
//            print(resultType)
//        }
//    }
}

//
//  XCTest+Extension.swift
//  PhotosPracticeApp
//
//  Created by Syed, Waseem on 10/27/19.
//  Copyright © 2019 Syed, Waseem. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func getJsonData(from fileName: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError()
        }
        return data
    }
    
    func getUrl(from fileName: String) -> URL {
        let bundle = Bundle(for: classForCoder)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError()
        }
        
        return url
    }
}

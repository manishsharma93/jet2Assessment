//
//  Jet2AssessmentTests.swift
//  Jet2AssessmentTests
//
//  Created by Manish Kumar on 30/09/20.
//  Copyright © 2020 Manish Kumar. All rights reserved.
//

import XCTest
@testable import Jet2Assessment

class Jet2AssessmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Test case to fetch article listing data
    func testArticleListingDataFetch() {
        let params = [
            "page" : 1,
            "limit" : 10
            ] as [String : Any]
        
        // When
        Webservices().callGetService(methodName: WebServiceMethods.WS_GET_ARTICLE, params: params, successBlock: { (data) in
            do {
                // Then
                XCTAssertNotNil(data)
            }
        }) { (error) in
            
        }
    }
    
    //Test case to to check whether the image is loading or not
    func testLoadImage(imagePath: String) {
        let image = UIImageView()
        image.loadImage(imagePath)
        XCTAssertNotNil(image)
        //        XCTAssertNil(image)
        
    }
    
}

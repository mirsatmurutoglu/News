//
//  NewsTests.swift
//  NewsTests
//
//  Created by mirsat on 27/11/17.
//  Copyright © 2017 mirsat. All rights reserved.
//

import XCTest
@testable import News

class NewsTests: XCTestCase {
    
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetNewsSources() {
        self.expectation = self.expectation(description: "test get news sources")
        NewsApi.getNewsSources { (data, _) in
            if data != nil {
                self.expectation?.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetNewsItems() {
        self.expectation = self.expectation(description: "test get news items")
        NewsApi.getNewsItems("bbc-news") { (data, _) in
            if data != nil {
                self.expectation?.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

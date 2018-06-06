//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by Yunis on 2018/6/4.
//  Copyright © 2018年 三十一. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_weatherDataAt_starts_the_session() {
        
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
        
        session.sessionDataTask = dataTask

        
        let url = URL(string: "https://darksky.net")!
        let manager = WeatherDataManager(
            baseURL: url,
            urlSession: session)
        
        manager.weatherDataAt(
            latitude: 52,
            longitude: 100,
            completion: { _, _ in  })
        
        
        
        XCTAssert(session.sessionDataTask.isResumeCalled)

    }

    
}

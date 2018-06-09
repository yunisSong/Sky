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
    //测试 resume 方法是否调用
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
    
    //测试 是否请求到数据
    func test_weatherDataAt_gets_data()  {
        
        let expect = expectation(description: "请求数据")
        
        var data : WeatherData? = nil
        WeatherDataManager.shared.weatherDataAt(latitude: 52, longitude: 100,completion: { (response, error) in
            data = response
            expect.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(data)
        
    }

    
    func test_weatherDataAt_handle_invalid_request()  {
        
        let section = MockURLSession()
        section.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
        let manmger = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: section)
        
        var  error:DataManagerError? = nil
        
        manmger.weatherDataAt(latitude: 52, longitude: 1, completion:  { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
        
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_to_200()  {
        
        let url = URL(string: "https://darksky.net")!

        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse.init(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        let manmger = WeatherDataManager(baseURL: url, urlSession: session)
        
        var  error:DataManagerError? = nil
        
        
        manmger.weatherDataAt(latitude: 52, longitude: 100, completion:  { (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
        
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        let url = URL(string: "https://darksky.net")!
        let session = MockURLSession()
        
        let data =
            """
        {
            "longitude" : 100,
            "latitude" : 52,
            "currently" :
                {
                    "temperature" : 23,
                    "humidity" : 0.91,
                    "icon" : "snow",
                    "time" : 1507180335,
                    "summary" : "Light Snow"
                }
        }
        """.data(using: .utf8)!
        
        session.responseHeader = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.responseData = data
        
        var decoded : WeatherData? = nil
        let manage = WeatherDataManager.init(baseURL: url, urlSession: session)
        manage.weatherDataAt(latitude: 52, longitude: 100) { (d, _) in
            decoded = d
        }
//        manage.weatherDataAt(latitude: 52, longitude: 100, completion:  { (d, _) in
//            decoded = d
//        })
        
        let expectde = WeatherData.init(latitude: 52, longitude: 100, currently: WeatherData.CurrentWeather.init(time: Date.init(timeIntervalSince1970: 1507180335), summary: "Light Snow", icon: "snow", temperature: 23, humidity: 0.91))
        
        XCTAssertEqual(decoded, expectde)


    }

























}
















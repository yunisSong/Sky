//
//  MockURLSession.swift
//  SkyTests
//
//  Created by Yunis on 2018/6/6.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSession: URLSessionProtocol {
    
    var responseData : Data?
    var responseHeader : HTTPURLResponse?
    var responseError : Error?

    var sessionDataTask = MockURLSessionDataTask()

    
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.dataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData,responseHeader,responseError)
        return sessionDataTask
    }
    
    

}

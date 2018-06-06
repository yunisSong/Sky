//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by Yunis on 2018/6/6.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
    
    func resume() {
        self.isResumeCalled = true
    }
}

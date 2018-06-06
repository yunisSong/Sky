//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by Yunis on 2018/6/6.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias dataTaskHandler =
        (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping dataTaskHandler)
        -> URLSessionDataTaskProtocol
}

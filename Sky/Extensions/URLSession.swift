//
//  URLSession.swift
//  Sky
//
//  Created by Yunis on 2018/6/6.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.dataTaskHandler) -> URLSessionDataTaskProtocol {
        return (dataTask(
            with: request,
            completionHandler: completionHandler)
            as URLSessionDataTask)
            as URLSessionDataTaskProtocol
    }
    
    
//    func dataTask(
//        with request: URLRequest,
//        completionHandler: @escaping DataTaskHandler)
//        -> URLSessionDataTaskProtocol {
//            return (dataTask(
//                with: request,
//                completionHandler: completionHandler)
//                as URLSessionDataTask)
//                as URLSessionDataTaskProtocol
//    }
    
}

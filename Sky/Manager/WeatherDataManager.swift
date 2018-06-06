//
//  WeatherDataManager.swift
//  Sky
//
//  Created by Yunis on 2018/5/31.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation

//错误枚举类
enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}


//网络请求管理类
final class WeatherDataManager {
    internal let baseURL : URL
    internal let urlSession :URLSessionProtocol
    internal init(baseURL : URL, urlSession: URLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    //单例 初始化
    static let shared = WeatherDataManager(baseURL: API.authenticatedURL,urlSession: URLSession.shared)
    
    //定义回调函数 typealias 别名
    typealias CompletionHandler = (WeatherData?,DataManagerError?) -> Void
    
    // 发送网络请求
    func weatherDataAt(latitude: Double,longitude: Double,completion: @escaping CompletionHandler) {
        
        let url = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        
        var request = URLRequest(url:url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.urlSession.dataTask(with: request, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
            }
        }).resume()
    }
    
    //网络请求数据处理 回调
    func didFinishGettingWeatherData(data: Data?,response: URLResponse?,error: Error?,completion: CompletionHandler)  {
        
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data,
            let response = response as? HTTPURLResponse {
            
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                }catch {
                    completion(nil, .invalidResponse)
                }
            }else {
                completion(nil, .failedRequest)

            }
            
        }else
        {
            completion(nil, .unknown)

        }
        
    }
}




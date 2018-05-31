//
//  WeatherData.swift
//  Sky
//
//  Created by Yunis on 2018/5/31.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation


struct WeatherData: Codable {
    let latitude : Double
    let longitude : Double
    let currently : CurrentWeather
    
    
    struct CurrentWeather : Codable {
        let time : Date
        let summary : String
        let icon : String
        let temperature : Double
        let humidity : Double
    }
}

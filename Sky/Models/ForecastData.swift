//
//  ForecastData.swift
//  Sky
//
//  Created by Yunis on 2018/6/13.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation
struct ForecastData : Codable {
    
    let time : Date
    let temperatureLow : Double
    let temperatureHigh : Double
    let icon : String
    let humidity : Double
 
}

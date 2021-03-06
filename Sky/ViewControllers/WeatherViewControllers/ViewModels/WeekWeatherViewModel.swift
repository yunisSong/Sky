//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by Yunis on 2018/6/13.
//  Copyright © 2018年 三十一. All rights reserved.
//

import UIKit



struct WeekWeatherViewModel {

    let weatherData : [ForecastData]
    
    private let dateFormatter = DateFormatter()
    
    func week(for index:Int) -> String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func date(for index: Int) -> String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: weatherData[index].time)
    }
    
    func temperature(for index: Int) -> String {
        
        let min = String(format: "%.0f °C",
                         weatherData[index].temperatureLow.toCelcius())
        let max = String(format: "%.0f °C",
                         weatherData[index].temperatureHigh.toCelcius())
        
        return "\(min) - \(max)"
        
    }
    
    func weatherIcon(for index: Int) -> UIImage? {
        return UIImage.weatherIcon(of: weatherData[index].icon)
    }
    
    func humidity(for index: Int) -> String {
        return String(format: "%.0f %%", weatherData[index].humidity)
    }
    
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        print("log = \(weatherData.count)")
        return weatherData.count
    }
    
    
}


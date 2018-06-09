//
//  Double.swift
//  Sky
//
//  Created by Yunis on 2018/6/8.
//  Copyright © 2018年 三十一. All rights reserved.
//

import Foundation

extension Double {
    func toCelcius() -> Double {
        return (self - 32.0) / 1.8
    }
}

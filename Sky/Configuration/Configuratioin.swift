//
//  Configuratioin.swift
//  Sky
//
//  Created by Yunis on 2018/5/31.
//  Copyright © 2018年 Mars. All rights reserved.
//

import Foundation

struct API {
    static let key = "b027d54d74819767c410e6950dcada38"
    static let baseURL = URL(string: "https://api.darksky.net/forecast")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}


//
//  URL.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
typealias DownloadComplete = () -> ()

enum cityURL: String {
    case tokyo = "api.openweathermap.org/data/2.5/forecast?id=1850147&appid=9eb78416466a2480d3da80192164b38c"
    case copenhagen = "api.openweathermap.org/data/2.5/forecast?id=2618425&appid=9eb78416466a2480d3da80192164b38c"
    case london = "api.openweathermap.org/data/2.5/forecast?id=2643743&appid=9eb78416466a2480d3da80192164b38c"
}

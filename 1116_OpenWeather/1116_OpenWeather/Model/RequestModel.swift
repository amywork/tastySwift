//
//  RequestModel.swift
//  1116_OpenWeather
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  City View Controller에서 시험 삼아 써보기

import Foundation
class RequestModel {
    
    static var shared = RequestModel()
    var todayWeather: TodayWeather?
    private init() {}
 
    public func fetchToday(string: String, completion: @escaping ()->Void) {
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let mainDic = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    self.todayWeather = TodayWeather(dic: mainDic)
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch let err {
                    print("\(err.localizedDescription)")
                }
            }
            }.resume()
    }
    
}

//
//  RequestModel.swift
//  1116_OpenWeather
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  Singleton Request Manager

import Foundation

//  For sharing Weather Data
internal class WeatherData {
    static var shared = WeatherData()
    private init() {}
    
    public var forecasts: [Forecast] = []
    public var todayWeather: TodayWeather?
}

//  For Request
internal class RequestManager {
    
    static var shared = RequestManager()
    private init() {}
    
    private let session = URLSession.shared
    typealias FetchTodayCompletion = (_ isSucess: Bool, _ data: Any?, _ error: Error?) -> Void
    typealias FetchForecastCompletion = (_ isSucess: Bool, _ error: Error?) -> Void
    
    public func fetchToday(string: String, completion: @escaping FetchTodayCompletion) {
        
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            
            // 01. server error 캐치
            if let err = error {
                print(err.localizedDescription)
            }
                
                // 02. Response까지는 왔을 경우
            else if let data = data, let response = response as? HTTPURLResponse  {
                let codeLevel = response.statusCode / 100
               
                switch codeLevel {
                case 1:
                    completion(false, data, nil)
                    print("100 에러")
                case 2:
                    do {
                        let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                        WeatherData.shared.todayWeather = TodayWeather(dic: jsonDic)
                        completion(true, jsonDic, nil)
                    } catch let err {
                        // JSONSerialization 에러
                        print("\(err.localizedDescription)")
                    }
                case 3:
                    completion(false, data, nil)
                    print("300 에러")
                case 4:
                    completion(false, data, nil)
                    print("400 에러")
                case 5:
                    completion(false, data, nil)
                    print("500 에러")
                default:
                    break
                }
                
            }
                
                // 03. server error도 없고, response도 없는 경우
            else {
                completion(false, nil, nil)
                print("Unknowned error")
            }
            
            // 04. dataTask 실행
            }.resume()
    }
    
    public func fetchForecast(string: String, completion: @escaping FetchForecastCompletion) {
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            
            // 01. server error 캐치
            if let err = error {
                print(err.localizedDescription)
            }
                
                // 02. Response까지는 왔을 경우
            else if let data = data, let response = response as? HTTPURLResponse  {
                let codeLevel = response.statusCode / 100
                switch codeLevel {
                case 1:
                    completion(false, nil)
                    print("100 에러")
                case 2:
                    do {
                        let jsonDic = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                        if let list = jsonDic["list"] as? [Dictionary<String, AnyObject>] {
                            WeatherData.shared.forecasts = []
                            for dic in list {
                                if let forecast = Forecast(weatherDict: dic) {
                                    WeatherData.shared.forecasts.append(forecast)
                                }
                            }
                        }
                        completion(true, nil)
                    }catch let err {
                        // JSONSerialization 에러
                        print("\(err.localizedDescription)")
                    }
                case 3:
                    completion(false, nil)
                    print("300 에러")
                case 4:
                    completion(false, nil)
                    print("400 에러")
                case 5:
                    completion(false, nil)
                    print("500 에러")
                default:
                    break
                }
            }
                
                // 03. server error도 없고, response도 없고!
            else {
                completion(false, nil)
            }
            
            // 04. dataTask 실행
            }.resume()
    }
    
}


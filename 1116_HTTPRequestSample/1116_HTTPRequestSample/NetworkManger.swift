//
//  NetworkManger.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

// 고도화 예정
enum URLName: String {
    case base = "ddd"

    var login: String {
        return self.rawValue + "/member/login/"
    }
    
    var signup: String {
        return self.rawValue + "/member/signup/"
    }
}

// 추가 예정
let baseURL = "http://api-ios-dev.ap-northeast-2.elasticbeanstalk.com/api"
let signupURI = "/member/signup/"

class NetworkManger {
    
    static var shared: NetworkManger = NetworkManger()
    private init() {
        loadToken()
    }
    typealias Completion = (_ isSucess: Bool, _ returnValue: Any?, _ error: Error?) -> Void
    
    var token: String?
    private let session = URLSession.shared
    
    func requestSingup(id: String, pw: String, completion: @escaping Completion) {
        let url = URL(string: baseURL + signupURI)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // Default Content Type: key=value&key=value
        // JSON 타입이라면? "{username:\(id),password1:\(pw),password2:\(pw)}"
        // httpBody = Data 타입으로 전환하여 보내야 함
        let httpBodyDataStr = "username=\(id)&password1=\(pw)&password2=\(pw)"
        request.httpBody = httpBodyDataStr.data(using: .utf8)
            
        session.dataTask(with: request) { [unowned self] (data, response, serverError) in
        
            let codeLevel = (response as! HTTPURLResponse).statusCode
            
            switch codeLevel {
            case 201:
                let dic = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:String]
                self.token = dic["key"]
                print("token이 발급되었습니다.")
                completion(true, nil, nil)
            default:
                completion(false, nil, nil)
                print("codeLevel is not 201")
            }
        
        }.resume()
    }
   
    
    
    // Appdelegate Background에서 실행
    func saveToken() {
        if let token = token {
            UserDefaults.standard.set(token, forKey: "TokenKey")
        }
    }
    
    func loadToken() {
        if let token = UserDefaults.standard.string(forKey: "TokenKey") {
            self.token = token
        }
    }
    
}









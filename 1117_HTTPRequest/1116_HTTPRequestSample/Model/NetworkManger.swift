//
//  NetworkManger.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation

enum URLName: String {
    case base = "http://api-ios-dev.ap-northeast-2.elasticbeanstalk.com/api"

    var login: String {
        return self.rawValue + "/member/login/"
    }
    
    var signup: String {
        return self.rawValue + "/member/signup/"
    }
}

class NetworkManger {
    
    static var shared: NetworkManger = NetworkManger()
    private init() {
        loadToken()
    }
    
    typealias Completion = (_ isSucess: Bool, _ returnValue: Any?, _ error: Error?) -> Void
    
    public var token: String?
    private let session = URLSession.shared
    
    func requestSingup(id: String, pw: String, completion: @escaping Completion) {
        let url = URL(string: URLName.base.signup)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // Default Content Type: key=value&key=value
        // JSON 타입이라면? "{username:\(id),password1:\(pw),password2:\(pw)}"
        // httpBody = Data 타입으로 전환하여 보내야 함
       
        let httpBodyDataStr = "username=\(id)&password1=\(pw)&password2=\(pw)"
        request.httpBody = httpBodyDataStr.data(using: .utf8)
            
        session.dataTask(with: request) { [unowned self] (data, response, serverError) in
        
            if let err = serverError {
                print(err.localizedDescription)
            }
            
            else if let data = data, let response = response {
                let codeLevel = (response as! HTTPURLResponse).statusCode
                switch codeLevel {
                case 201:
                    let dic = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
                    self.token = dic["key"]
                    print("token이 발급되었습니다.")
                    completion(true, nil, nil)
                default:
                    completion(false, nil, nil)
                    print("response failed - code is not 201")
                }
            }
            
            else {
                print("unknowned error")
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









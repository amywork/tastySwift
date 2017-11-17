//
//  NetworkManger.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

enum URLName: String {
    case base = "http://api-ios-dev.ap-northeast-2.elasticbeanstalk.com/api"

    var login: String {
        return self.rawValue + "/member/login/"
    }
    
    var signup: String {
        return self.rawValue + "/member/signup/"
    }
    
    var post: String {
        return self.rawValue + "/post/"
    }
}

class NetworkManger {
    
    static var shared: NetworkManger = NetworkManger()
    private init() {
        loadToken()
    }
    
    typealias Completion = (_ isSucess: Bool, _ data: Any?, _ error: Error?) -> Void
    
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
            DataCenter.shared.token = token
        }
    }
    
    func loadToken() {
        if let token = UserDefaults.standard.string(forKey: "TokenKey") {
            self.token = token
        }
    }
    
    // MARK : request to get all posts
    func requestGetPosts(completion: @escaping Completion) {
        print("requestGetPosts 실행은 성공했습니다.")
        let url = URL(string: URLName.base.post)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // token dataCenter 로 옮기기
        request.addValue("Token \(self.token!)", forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
            }
                
            else if let data = data, let response = response {
                let codeLevel = (response as! HTTPURLResponse).statusCode / 100
                switch codeLevel {
                case 2:
                    print("데이터 요청 또한 성공했습니다.")
                    let decoder = JSONDecoder()
                    let modelList = try! decoder.decode([CardData].self, from: data)
                    print(modelList)
                    completion(true, modelList, nil)
                    // print(DataCenter.shared.cardList)
                    // 이전 방식: JSONSerialization
                    // let list = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                default:
                    completion(false, nil, nil)
                    print("response failed - code is not 200~")
                }
            }
            else {
                print("unknowned error: no response & no error")
            }
        }.resume()
        
        
    }
    
    
    // MARK : post new content to server (신규 생성!)
    func requestToPosting(model: CardData, completion: @escaping Completion) {
        print("포스팅을 실행하겠습니다.")
        let url = URL(string: URLName.base.post)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Token \(self.token!)", forHTTPHeaderField: "Authorization")
        
        let boundary: String = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let param = model.param
        let imgData = model.imgData
        let fileName = model.title
        let body = self.createBody(parameters: param, boundary: boundary, data: imgData!, dataType: "img_cover", mimeType: ".", filename: fileName)
        request.httpBody = body
        
        session.dataTask(with: request) { (data, response, error) in
            
            // Catch server error
            if let err = error {
                print(err.localizedDescription)
            }
                
            else if let data = data, let response = response {
                let codeLevel = (response as! HTTPURLResponse).statusCode / 100
                switch codeLevel {
                case 2:
                    print("포스팅에 성공했습니다.")
                    let decoder = JSONDecoder()
                    let newModel = try! decoder.decode(CardData.self, from: data)
                    print(newModel)
                    completion(true, newModel, nil)
                default:
                    completion(false, nil, nil)
                    print("response failed - code is not 200~")
                }
            }
            else {
                print("unknowned error: no response & no error")
            }
            }.resume()
        
    }
    
    // MARK : private Method
    // Multipart Data 만들기
    private func createBody(parameters: [String:String],
                            boundary: String,
                            data: Data,
                            dataType: String,
                            mimeType: String,
                            filename: String) -> Data {
        
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        body.appendString(boundaryPrefix)

        body.appendString("Content-Disposition: form-data; name=\(dataType)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--")
      
        return body
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}

extension Data {
    
    mutating func appendString(_ str: String) {
        let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }

}

var cache: [String:Data] = [:]
extension UIImageView {
    
    func loadImgData(_ urlString: String) {
        if cache.keys.contains(urlString) {
            let data = cache[urlString]!
            self.image = UIImage(data: data)
        }else {
            DispatchQueue.global().sync {
                if let data = try? Data(contentsOf: URL(string: urlString)!) {
                    DispatchQueue.main.async { [unowned self] in
                        self.image = UIImage(data: data)
                    }
                    cache.updateValue(data, forKey: urlString)
                }
            }
        }
    }
    
}




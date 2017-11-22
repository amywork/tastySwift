//
//  Extensions.swift
//  Onstagram
//
//  Created by 김기윤 on 22/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(URLstring : String, completion: @escaping (_ data: Data)->Void) {
        let url = URL(string : URLstring)!
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("해당 image url에 이미지가 없습니다.")
                print(error.localizedDescription)
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    completion(data)
                }
            }
            }.resume()
    }
    
}


extension UIImage {
    func makeImgDate() -> Data {
        return UIImageJPEGRepresentation(self, 0.5)!
    }
}

extension Notification.Name {
    static let newPost : Notification.Name = Notification.Name("newPost")
}


extension UIStoryboard {
    
    static var main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    func makeSignupVC() -> SignupVC {
        return self.instantiateViewController(withIdentifier: "SignUpVC") as! SignupVC
    }
    
    func makeLoginVC() -> LoginVC {
        return self.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    }
    
}

//
//  Extensions.swift
//  Onstagram
//
//  Created by 김기윤 on 22/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation
import UIKit

var imageCache = [String:UIImage]()
extension UIImageView {
    
    func loadImage(URLstring : String, completion: @escaping (_ isSuccess: Bool)->Void) {
        
        self.image = nil
        
        if let cachedImage = imageCache[URLstring] {
            self.image = cachedImage
            completion(true)
            return
        }
        
        guard let url = URL(string : URLstring) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let photoImage = UIImage(data: data)
                imageCache[url.absoluteString] = photoImage
                DispatchQueue.main.async {
                    self.image = photoImage
                    completion(true)
                }
            }
            }.resume()
    }
    
}

extension UIImage {
    func generateJPEGData() -> Data {
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
    
    func makeCommentVC() -> CommentVC {
        return self.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
    }
    
}

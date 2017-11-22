//
//  DataCenter.swift
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*Signleton DataCenter*/
class DataCenter {
    
    static var shared: DataCenter = DataCenter()
    var currentUser: UserModel?
    private init() { }
    
    /*Firebase Manager : Load User*/
    
    typealias completion = (_ user: UserModel?, _ snapshot: Any?) -> Void
    // MARK: - Download current user from server
    func loadCurrentUser(completion: @escaping completion) {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else  { return }
            let uid = user.uid
            let ref = Database.database().reference().child(uid)
            ref.observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? [String:Any] {
                    DispatchQueue.main.async {
                        let user = UserModel(email: email, uid: uid)
                        completion(user, value)
                    }
                }
            })
        }
    }
    
    /*Firebase Manager : Upload*/
    
    // MARK: - upload profile img to server
    func uploadImg(selectedImgData : Data, filename : String ) {
        Storage.storage().reference().child("profile_imgs").child(filename).putData(selectedImgData, metadata: nil) { (metadata, error) in
            guard let profileImgUrl = metadata?.downloadURL()?.absoluteString else {return}
            guard let uid = self.currentUser?.uid else {return}
            let dic = ["profile_img_url" : profileImgUrl]
            Database.database().reference().child(uid).updateChildValues(dic, withCompletionBlock: { (error, ref) in
                print("uploadImg 성공")
            })
        }
    }
    
    // MARK: - upload user info(name&status) to server
    func uploadUserInfo(nickName : String, status : String) {
        guard let uid = self.currentUser?.uid else {return}
        let dic = ["nickname" : nickName, "status" : status]
        Database.database().reference().child(uid).updateChildValues(dic) { (error, ref) in
            print("uploadUserInfo 성공")
        }
    }
    
    // MARK: - upload posting to server
    func uploadPost(img: Data, contents: String, filename : String, index : Int) {
        Storage.storage().reference().child("post_imgs").child(filename).putData(img, metadata: nil) { (metadata, error) in
            guard let postImgUrl = metadata?.downloadURL()?.absoluteString else {return}
            guard let uid = self.currentUser?.uid else {return}
            let postdic = ["post_img_url" : postImgUrl, "contents" : contents]
            let postNode = Database.database().reference().child(uid).child("POST").child("\(index)")
            postNode.updateChildValues(postdic, withCompletionBlock: { (error, ref) in
                print("postupload 성공")
            })
        }
    }

}

extension UIImageView {
   
    func loadImage(URLstring : String, completion: @escaping (_ data: Data)->Void) {
        let url = URL(string : URLstring)!
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("해당 url에 이미지없음")
                print(error)
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

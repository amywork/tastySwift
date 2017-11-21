//
//  DataCenter.swift
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class DataCenter {
    
    static var shared: DataCenter = DataCenter()
    var currentUser: UserModel?
 
    private init() {
        loadCurrentUser()
    }
    
    // MARK: - Load User Info
    private func loadCurrentUser() {
        if let user = Auth.auth().currentUser {
            let email = user.email!
            let uid = user.uid
            currentUser = UserModel(email: email, uid: uid)
            let ref = Database.database().reference().child(uid)
            ref.observe(.value, with: { [weak self] snapshot in
                if let value = snapshot.value as? [String:Any] {
                    let imgUrl: String? = value["profile_img_url"] as? String
                    let nickName: String? = value["nickname"] as? String
                    let status: String? = value["status"] as? String
                    self?.currentUser?.profileImgUrl = imgUrl
                    self?.currentUser?.nickName = nickName
                    self?.currentUser?.status = status
                    if let _ = self?.currentUser, let url = self?.currentUser?.profileImgUrl {
                        self?.loadProfile(imgUrl: url)
                    }
                }
            })
        }
    }
    
    // MARK: - Firebase Manager
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
    
    func uploadUserInfo(nickName : String, status : String) {
        guard let uid = self.currentUser?.uid else {return}
        let dic = ["nickname" : nickName, "status" : status]
        Database.database().reference().child(uid).updateChildValues(dic) { (error, ref) in
            print("uploadUserInfo 성공")
        }
    }
    
    func loadProfile(imgUrl: String) {
        let ref = Storage.storage().reference(forURL: imgUrl)
        ref.getData(maxSize: 1 * 1024 * 1024) { [weak self] data, error in
            if error != nil {
                print("Uh-oh, an error occurred!")
            } else {
                let image = UIImage(data: data!)
                self?.currentUser?.profileImg = image
            }
        }
    }
}


struct UserModel {
    var email: String
    var uid: String
    
    var profileImg : UIImage?
    var profileImgData : Data? {
        if let img = self.profileImg {
            return UIImageJPEGRepresentation(img, 0.5)!
        }
        return nil
    }
    
    var profileImgUrl: String?
    var nickName: String?
    var status: String?
    
    init(email: String, uid: String){
        self.email = email
        self.uid = uid
    }
}


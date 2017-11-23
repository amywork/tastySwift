//
//  FirebaseManager.swift
//  Onstagram
//
//  Created by ilhan won on 2017. 11. 22..
//  Copyright © 2017년 yunari.me. All rights reserved.
//  Signleton FirebaseManager
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*Signleton FirebaseManager*/
class FirebaseManager {
    
    // MARK: - Property
    static var shared: FirebaseManager = FirebaseManager()
    var currentUser: UserModel!    
    var uid: String {
        return currentUser.uid
    }
    
    private init() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user {
                self?.currentUser = UserModel(uid: user.uid)
            }
        }
    }
    
    typealias completion = (_ snapshot: Any?) -> Void
    typealias removeCompletion = (_ isSuccess: Bool) -> Void
    
    // MARK: - Download current user from server
    func loadCurrentUser(completion: @escaping completion) {
        if let user = Auth.auth().currentUser {
            self.currentUser = UserModel(uid: user.uid)
            let ref = Database.database().reference().child(uid)
            ref.observeSingleEvent(of: .value, with: { snapshot in
                if let dic = snapshot.value as? [String:Any] {
                    DispatchQueue.main.async {
                        completion(dic)
                    }
                }
            })
        }
    }
    
    
    /*Firebase Upload*/
    
    // MARK: - upload profile image to server
    func uploadImg(selectedImgData : Data) {
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("profile_imgs").child(filename).putData(selectedImgData, metadata: nil) { (metadata, error) in
            guard let profileImgUrl = metadata?.downloadURL()?.absoluteString else {return}
            let dic = ["profile_img_url" : profileImgUrl]
            Database.database().reference().child(self.uid).updateChildValues(dic, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("uploadImg 성공")
                }else {
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    // MARK: - upload posting to server
    typealias uploadKeySuccess = (_ isSucess: Bool, _ postKey: String?) -> Void
    func uploadPost(imgData: Data, contents: String, completion: @escaping uploadKeySuccess) {
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("post_imgs").child(filename).putData(imgData, metadata: nil) { (metadata, error) in
            guard let postImgUrl = metadata?.downloadURL()?.absoluteString else { return }
            let postRef = Database.database().reference().child(self.uid).child("POST")
            let key =  postRef.childByAutoId().key
            let postdic = ["post_img_url" : postImgUrl, "contents" : contents]
            postRef.child(key).updateChildValues(postdic, withCompletionBlock: { (error, ref) in
                if error == nil {
                    completion(true, key)
                    print("postupload 성공")
                }else {
                    completion(false, nil)
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    // MARK: - upload user info(nickName & status message) to server
    func uploadUserInfo(nickName : String, status : String) {
        let dic = ["nickname" : nickName, "status" : status]
        Database.database().reference().child(self.uid).updateChildValues(dic) { (error, ref) in
            print("uploadUserInfo성공")
        }
    }
    
    
    // MARK: - remove post from server
    func removeSinglePost(key: String, completion: @escaping removeCompletion) {
        let postRef = Database.database().reference().child(self.uid).child("POST")
        postRef.child(key).removeValue { (error, ref) in
            if error == nil {
                completion(true)
            }
            completion(false)
            print(error.debugDescription)
        }
    }
    
    // MARK: - upload comment to server
    func uploadComment(postKey: String, body: String, completion: @escaping uploadKeySuccess) {
        let ref = Database.database().reference().child(self.uid).child("Comment").child(postKey)
        let key = ref.childByAutoId().key
        let comment = ["body" : body]
        ref.child(key).updateChildValues(comment) { (err, ref) in
            if err == nil {
                completion(true, key)
                print("Comment Upload 성공")
            }
            completion(false, nil)
        }
    }

}

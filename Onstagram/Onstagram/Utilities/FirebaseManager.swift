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
    var currentUser: UserModel?
    private init() {
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user {
                self?.currentUser = UserModel(email: user.email!, uid: user.uid)
            }
        }
    }
    
    typealias completion = (_ snapshot: Any?) -> Void
   
    // MARK: - Download current user from server
    func loadCurrentUser(completion: @escaping completion) {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            guard let email = user.email else  { return }
            self.currentUser = UserModel(email: email, uid: uid)
            let ref = Database.database().reference().child(uid)
            ref.observeSingleEvent(of: .value, with: { snapshot in
                if let snapshotDictionary = snapshot.value as? [String:Any] {
                    DispatchQueue.main.async {
                        completion(snapshotDictionary)
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
            guard let uid = self.currentUser?.uid else {return}
            let dic = ["profile_img_url" : profileImgUrl]
            Database.database().reference().child(uid).updateChildValues(dic, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("uploadImg 성공")
                }else {
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    // MARK: - upload posting to server
    func uploadPost(imgData: Data, contents: String, index : Int) {
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("post_imgs").child(filename).putData(imgData, metadata: nil) { (metadata, error) in
            guard let uid = self.currentUser?.uid else { return }
            guard let postImgUrl = metadata?.downloadURL()?.absoluteString else { return }
            let postdic = ["post_img_url" : postImgUrl, "contents" : contents]
            Database.database().reference().child(uid).child("POST").child("\(index)").updateChildValues(postdic, withCompletionBlock: { (error, ref) in
                if error == nil {
                    print("postupload 성공")
                }else {
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    // MARK: - upload user info(nickName & status message) to server
    func uploadUserInfo(nickName : String, status : String) {
        guard let uid = self.currentUser?.uid else {return}
        let dic = ["nickname" : nickName, "status" : status]
        Database.database().reference().child(uid).updateChildValues(dic) { (error, ref) in
            print("uploadUserInfo성공")
        }
    }
    
}


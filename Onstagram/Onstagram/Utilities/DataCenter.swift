import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

/*Signleton DataCenter*/
// 01. Managing connection with Firebase
// 02. Store currentUser

class DataCenter {
    
    static var shared: DataCenter = DataCenter()
    var currentUser: UserModel?
    private init() { }
    
    /*Firebase Manager*/
    typealias completion = (_ user: UserModel?, _ snapshot: Any?) -> Void
   
    // MARK: - Download current user from server
    func loadCurrentUser(completion: @escaping completion) {
        if let user = Auth.auth().currentUser {
            guard let email = user.email else  { return }
            let uid = user.uid
            let ref = Database.database().reference().child(uid)
            ref.observeSingleEvent(of: .value, with: { [ weak self ] snapshot in
                if let value = snapshot.value as? [String:Any] {
                    DispatchQueue.main.async {
                        let user = UserModel(email: email, uid: uid)
                        self?.currentUser = user
                        completion(user, value)
                    }
                }
            })
        }
    }
    
    /*Firebase Upload*/
    
    // MARK: - upload profile image to server
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
    
    // MARK: - upload posting to server
    func uploadPost(img: Data, contents: String, filename : String, index : Int) {
        Storage.storage().reference().child("post_imgs").child(filename).putData(img, metadata: nil) { (metadata, error) in
            guard let uid = self.currentUser?.uid else { return }
            guard let postImgUrl = metadata?.downloadURL()?.absoluteString else { return }
            let postdic = ["post_img_url" : postImgUrl, "contents" : contents]
            print("포스트딕셔너리")
            print(postdic)
            Database.database().reference().child(uid).child("POST").child("\(index)").updateChildValues(postdic, withCompletionBlock: { (error, ref) in
                print("postupload 성공")
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


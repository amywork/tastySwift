//
//  DataCenter.swift
//

import Foundation
import Firebase
import FirebaseAuth

class DataCenter {
    static var shared: DataCenter = DataCenter()
    var currentUser: UserModel?
    
    private init() { }

}


struct UserModel {
    var email: String
    var uid: String
    
    init(_ email: String, _ uid: String){
        self.email = email
        self.uid = uid
    }
}

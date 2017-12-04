
import Foundation

final class UserModel {
  
  var model: [User] = [
    User(username: "FC1", password: "1234"),
    User(username: "FC2", password: "4321"),
    User(username: "FC3", password: "5135"),
  ]
  
  struct User {
    var username: String
    var password: String
  }
  
  func findUser(name: String, password: String) -> Bool {
    
    for user in model {
      if user.username == name && user.password == password {
        return true
      }
    }
    
    return false
  }
  
  
  
  func addUser(name: String, password: String) {
    let newUser = User(username: name, password: password)
    model.append(newUser)
  }
  
  
  
  
  
  
  
  
  
}


import Foundation

struct User: Codable {
  
  let username: String
  var email: String
  var password: String
  
}

struct Users: Codable {
  
  var users: [User]
  
}

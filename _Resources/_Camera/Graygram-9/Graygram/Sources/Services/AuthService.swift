import Alamofire

// -ing: NSCoding (objc)
// -able: Codable (swift)
// -type (swift)

struct AuthService: APIServiceType {
  static func login(
    username: String,
    password: String,
    completion: @escaping (DataResponse<Void>) -> Void
  ) {
    let urlString = self.url("/login/username")
    let parameters: Parameters = [
      "username": username,
      "password": password,
    ]
    let headers: HTTPHeaders = [
      "Accept": "application/json",
    ]
    Alamofire
      .request(urlString, method: .post, parameters: parameters, headers: headers)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let newResponse = response.mapResult { value -> Void in
          return Void()
        }
        completion(newResponse)
      }
  }
}













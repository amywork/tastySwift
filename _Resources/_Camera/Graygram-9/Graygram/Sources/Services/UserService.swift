import Alamofire
import ObjectMapper

struct UserService: APIServiceType {
  static func me(_ completion: @escaping (DataResponse<User>) -> Void) {
    let urlString = self.url("/me")
    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let newResponse = response.flatMapResult { json -> Result<User> in
          if let user = Mapper<User>().map(JSONObject: json) {
            return .success(user)
          } else {
            return .failure(MappingError())
          }
        }
        completion(newResponse)
      }
  }
}
















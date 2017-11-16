import Alamofire
import ObjectMapper

struct PostService: APIServiceType {

  // 미션:
  //   * Post ID를 가지고 단일 Post에 대한 정보를 얻어올 수 있는 서비스 로직을 작성해보세요.
  //   * /posts/<id>

  static func post(id: Int, completion: @escaping (DataResponse<Post>) -> Void) {
    let urlString = self.url("/posts/\(id)")
    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let newResponse = response.flatMapResult { json -> Result<Post> in
          if let post = Mapper<Post>().map(JSONObject: json) {
            return .success(post)
          } else {
            return .failure(MappingError())
          }
        }
        completion(newResponse)
      }
  }

  // 미션:
  // 1. like()
  // 2. unlike()

  static func like(
    postID: Int,
    completion: ((DataResponse<Void>) -> Void)? = nil
  ) {
    NotificationCenter.default.post(
      name: .postDidLike,
      object: self,
      userInfo: ["postID": postID]
    )
    let urlString = self.url("/posts/\(postID)/likes")
    Alamofire.request(urlString, method: .post)
      .responseJSON { response in
        if case .failure = response.result, response.response?.statusCode != 409 {
          NotificationCenter.default.post(
            name: .postDidUnlike,
            object: self,
            userInfo: ["postID": postID]
          )
        }
        let newResponse = response.mapResult { _ in }
        completion?(newResponse)
      }
  }

  static func unlike(
    postID: Int,
    completion: ((DataResponse<Void>) -> Void)? = nil
  ) {
    NotificationCenter.default.post(
      name: .postDidUnlike,
      object: self,
      userInfo: ["postID": postID]
    )
    let urlString = self.url("/posts/\(postID)/likes")
    Alamofire.request(urlString, method: .delete)
      .responseJSON { response in
        if case .failure = response.result, response.response?.statusCode != 409 {
          NotificationCenter.default.post(
            name: .postDidLike,
            object: self,
            userInfo: ["postID": postID]
          )
        }
        let newResponse = response.mapResult { _ in }
        completion?(newResponse)
      }
  }

  static func create(
    image: UIImage,
    message: String?,
    progress: @escaping (Progress) -> Void,
    completion: @escaping (DataResponse<Post>) -> Void
  ) {
    let urlString = self.url("/posts")
    Alamofire.upload(
      multipartFormData: { formData in
        if let imageData = UIImageJPEGRepresentation(image, 1) {
          formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
        }
        if let textData = message?.data(using: .utf8) {
          formData.append(textData, withName: "message")
        }
      },
      to: urlString,
      method: .post,
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let request, _, _):
          print("인코딩 성공: \(request)")
          request
            .uploadProgress(closure: progress)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
              let newResponse = response.flatMapResult { json -> Result<Post> in
                if let post = Mapper<Post>().map(JSONObject: json) {
                  return .success(post)
                } else {
                  return .failure(MappingError())
                }
              }
              if let post = newResponse.result.value {
                NotificationCenter.default.post(
                  name: .postDidCreate,
                  object: self,
                  userInfo: ["post": post]
                )
              }
              completion(newResponse)
            }

        case .failure(let error):
          print("인코딩 실패: \(error)")
          let response = DataResponse<Post>(
            request: nil,
            response: nil,
            data: nil,
            result: .failure(error)
          )
          completion(response)
        }
      }
    )
  }
}






























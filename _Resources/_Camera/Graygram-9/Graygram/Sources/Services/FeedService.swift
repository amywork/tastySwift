import Alamofire
import ObjectMapper

struct FeedService: APIServiceType {
  static func feed(
    paging: Paging,
    completion: @escaping (DataResponse<Feed>) -> Void
  ) {
    let urlString: String
    switch paging {
    case .refresh:
      urlString = self.url("/feed")
    case .next(let nextURLString):
      urlString = nextURLString
    }

    Alamofire.request(urlString)
      .validate(statusCode: 200..<400)
      .responseJSON { response in
        let newResponse = response.flatMapResult { json -> Result<Feed> in
          if let feed = Mapper<Feed>().map(JSONObject: json) {
            return .success(feed)
          } else {
            return .failure(MappingError())
          }
        }
        completion(newResponse)
      }
  }
}

























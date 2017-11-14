import ObjectMapper

struct Post: Mappable {
  var id: Int!
  var user: User!
  var photoID: String!
  var message: String?
  var isLiked: Bool!
  var likeCount: Int!
  var createdAt: Date!

  init?(map: Map) {
    // validation (return nil)
  }

  mutating func mapping(map: Map) {
    id <- map["id"]
    user <- map["user"]
    photoID <- map["photo.id"]
    message <- map["message"]
    isLiked <- map["is_liked"]
    likeCount <- map["like_count"]
    createdAt <- (map["created_at"], ISO8601DateTransform())
    // "2017-05-31T08:18:14+0000"
    //  0000-00-00T00:00:00+0000 (ISO-8601)
  }
}

extension Notification.Name {
  /// 좋아요를 한 경우 발생하는 노티피케이션입니다. `userInfo`에 `postID: Int`가 전달됩니다.
  static let postDidLike: Notification.Name = .init("postDidLike")

  /// 좋아요를 취소한 경우 발생하는 노티피케이션입니다. `userInfo`에 `postID: Int`가 전달됩니다.
  static let postDidUnlike: Notification.Name = .init("postDidUnlike")

  /// 새로운 `Post`가 생성될 경우 발생합니다. `userInfo`에 `post: Post`가 전달됩니다.
  static let postDidCreate: Notification.Name = .init("postDidCreate")
}






















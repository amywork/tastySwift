import ObjectMapper

struct User: Mappable {
  var id: Int!
  var username: String!
  var photoID: String?

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
    id <- map["id"]
    username <- map["username"]
    photoID <- map["photo.id"]
  }
}

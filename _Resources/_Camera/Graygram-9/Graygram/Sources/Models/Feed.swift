import ObjectMapper

struct Feed: Mappable {
  var posts: [Post]?
  var nextURLString: String?

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
    self.posts <- map["data"]
    self.nextURLString <- map["paging.next"]
  }
}

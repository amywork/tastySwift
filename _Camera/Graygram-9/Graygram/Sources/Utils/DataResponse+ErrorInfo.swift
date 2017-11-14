import Alamofire

extension DataResponse {
  func errorInfo() -> (field: String, message: String)? {
    guard let data = self.data,
      let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
      let errorInfo = json["error"] as? [String: Any],
      let field = errorInfo["field"] as? String,
      let message = errorInfo["message"] as? String
    else { return nil }
    return (field, message)
  }
}

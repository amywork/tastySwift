import Alamofire

extension DataResponse {
  // DataResponse<Any> -map-> DataResponse<User>
  func mapResult<T>(_ transform: (Value) -> T) -> DataResponse<T> {
    return self.flatMapResult { value in
      return .success(transform(value))
    }
  }

  func flatMapResult<T>(_ transform: (Value) -> Result<T>) -> DataResponse<T> {
    switch self.result {
    case .success(let value):
      return DataResponse<T>(
        request: self.request,
        response: self.response,
        data: self.data,
        result: transform(value),
        timeline: self.timeline
      )

    case .failure(let error):
      return DataResponse<T>(
        request: self.request,
        response: self.response,
        data: self.data,
        result: .failure(error),
        timeline: self.timeline
      )
    }
  }
}

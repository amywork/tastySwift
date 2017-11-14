import UIKit

enum PhotoSize {
  case tiny
  case small
  case medium
  case large

  var pointSize: Int {
    switch self {
    case .tiny: return 20
    case .small: return 40
    case .medium: return 320
    case .large: return 640
    }
  }

  var pixelSize: Int {
    return self.pointSize * Int(UIScreen.main.scale)
  }
}

extension UIImageView {
  func setImage(photoID: String?, size: PhotoSize) {
    guard let photoID = photoID else {
      self.image = nil
      return
    }
    let pixel = size.pixelSize
    let urlString = "https://www.graygram.com/photos/\(photoID)/\(pixel)x\(pixel)"
    let url = URL(string: urlString)!
    self.kf.setImage(with: url)
  }
}









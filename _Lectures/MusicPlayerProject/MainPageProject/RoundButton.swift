

import UIKit

@IBDesignable
class RoundButton: UIButton {

//  var  radius: CGFloat = 0
  @IBInspectable var radius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = radius
    }
  }
  
}

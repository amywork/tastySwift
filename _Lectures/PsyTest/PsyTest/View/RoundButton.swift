
import UIKit

class RoundButton: UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.cornerRadius = 20
    self.layer.borderColor = self.tintColor.cgColor
    self.layer.borderWidth = 1
  }
  
}

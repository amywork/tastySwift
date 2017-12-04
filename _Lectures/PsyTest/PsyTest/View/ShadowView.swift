
import UIKit

class ShadowView: UIView {
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
    self.layer.shadowOffset = CGSize(width: 4, height: 4)
    self.layer.shadowOpacity = 0.5
  }
  
}

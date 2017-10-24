import UIKit

class ShadowView: UIView {
    
    // MARK : - StoryBoard Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // ShadowColor는 CGColor 이기때문에 UIColor로 바꿔줘야함
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.5
    }

}

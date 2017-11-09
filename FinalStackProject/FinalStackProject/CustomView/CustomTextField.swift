
import UIKit

class CustomTextField: UITextField {

    // 여기서는 추가적인 작업을 할 필요는 없기 때문에 required init을 안해줘도 됩니다.

    // leftViewRect의 목적은 CGRect를 반환하는 것, super 안불러도 OK
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewWidth = self.bounds.size.height / 3
        let resultRect = CGRect(x: 10, y: self.bounds.height/2-leftViewWidth/2, width: leftViewWidth, height: leftViewWidth)
        return resultRect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsetRect = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, 10, 0, 0))
        // 컨텐트 안쪽으로 들어가는 패딩값을 의미한다. (+는 패딩값이 커지고 -는 마진값이 커짐)
        return edgeInsetRect
    }
    
    /*
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(
            self.bounds,
            UIEdgeInsetsMake(0, self.bounds.size.height/2+10, 0, 0))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let edgeInsetRect = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(0, self.bounds.size.height/2+10, 0, 0))
        return edgeInsetRect
    }
    */

    // placeholder 스트링의 디자인
    func configureAttributedString(
        string: String,
        range: NSRange,
        stringColor: UIColor
    ){
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(
            NSAttributedStringKey.foregroundColor,
            value: stringColor,
            range: range)
        self.attributedPlaceholder = attributedString
    }
    
    // NSMutableAttributedString는 class이기 때문에 let으로 선언했으나 내부 속성 바꿔도 OK
    // NSString(string: "DDD").range(of: ) : 내가 원하는 영역의 index range 지점을 딱 받아줌

}

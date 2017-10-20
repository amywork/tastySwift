import UIKit
class CustomCellSample: UITableViewCell {
    
    @IBOutlet var switcher: UISwitch!
    
    var cellDelegate:CustomCellDelegate?
    var indexPath:IndexPath?
    var switchData:Bool = true {
        willSet {
            self.switcher.isOn = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func switchBtnHandler(_ sender: UISwitch) {
        cellDelegate?.customCellSwitched(self, didChangedSwitch: sender.isOn)
    }

}

protocol CustomCellDelegate {
    func customCellSwitched(_ cell:CustomCellSample, didChangedSwitch value:Bool)
}

//
//  ViewController.swift
//  1024
//
//  Created by Dabu on 2017. 10. 24..
//  Copyright © 2017년 Dabu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewController2Delegate {

  @IBOutlet weak var delegateLabel: UILabel!
  @IBOutlet weak var closureLabel: UILabel!
  @IBOutlet weak var notificationLabel: UILabel!
  
  @IBAction func didTapNextButton(_ sender: UIButton) {
    
    let storyboard = UIStoryboard(name: "Main1", bundle: nil)
    let viewController2 = storyboard.instantiateViewController(withIdentifier: "vc2") as! ViewController2
    viewController2.didTapButtonClosure = { string -> Void in
      self.closureLabel.text = string
    }
    
    
    viewController2.delegate = self
    viewController2.formerViewController = self
    present(viewController2, animated: true, completion: nil)
  }
  
  func didSendText(string: String) {
    delegateLabel.text = string
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(didSendNotification(notification:)), name: NSNotification.Name.init("send"), object: nil)
    
  }

  @objc func didSendNotification(notification: Notification) {
    if let textString = notification.object as? String {
      notificationLabel.text = textString
    }
  }
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
}


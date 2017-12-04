//
//  SongLyricViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 30..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class SongLyricViewController: UIViewController {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    var data:SongDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.titleLB.text = data?.title
        self.lyricsTextView.text = data?.lyric
    }

    
    @IBAction func closeAction(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

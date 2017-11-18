//
//  ViewController.swift
//  FirebaseDBSample
//
//  Created by 김기윤 on 18/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//


import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    // Firebase testing
    @IBOutlet weak var TF1: UITextField!
    @IBOutlet weak var TF2: UITextField!
    @IBOutlet weak var TF3: UITextField!
    @IBOutlet weak var TF4: UITextField!
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.observe(DataEventType.childAdded) { (DataSnapshot) in
            print("Item Addeds")
        }
        ref.observe(DataEventType.childRemoved) { (DataSnapshot) in
            print("Item Removed Key: ")
            print("Item Removed Value: ")
        }
        ref.observe(.childChanged) { (snapshot) in
            dump(snapshot.value)
        }
    }
    
    @IBAction func inserting(_ sender: UIButton) {
        let itemsRef = ref.child("FANXY")
        itemsRef.setValue( ["ZICO","ZIACO","DEAN","MILLIC"])
    }
    
    @IBAction func deleteing(_ sender: UIButton) {
        let itemsRef = ref.child("FANXY")
        itemsRef.removeValue()
    }
    
    @IBAction func selecting(_ sender: UIButton) {
        let itemsRef = ref.child("FANXY")
        itemsRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let name = snapshot.value as? [String]
            print(name)
        }
}

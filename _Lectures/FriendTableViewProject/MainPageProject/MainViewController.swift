//
//  MainViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var mainTableVIew: UITableView!
    
    var dataManager:ProfileDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager = ProfileDataManager()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager?.profilesData.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell

        let profileModel:ProfileModel = dataManager!.profilesData[indexPath.row]
        
        cell.data = profileModel
        
        cell.textLabel?.text = profileModel.nickname
        cell.detailTextLabel?.text = profileModel.statusDesc
        cell.imageView?.image = UIImage(named:profileModel.profileImageName)
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? ProfileTableViewCell else {return}
        guard let nextVC = segue.destination as? DetailViewController else {return}
        
        nextVC.data = cell.data
    }
 

}

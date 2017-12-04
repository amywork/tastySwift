//
//  ViewController.swift
//  WPhotoWitget
//
//  Created by youngmin joo on 2017. 11. 9..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainTable:UITableView!
    
    var selectedLikeCell:PhotoTableViewCell?
    var filltedList:[PhotoData] = []
    
    let searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: Notification.Name.AddPhotoDataNotification, object: nil, queue: nil) { (noti) in
            self.filltedList = DataCenter.main.photoList
            self.mainTable.reloadData()
        }
        
        filltedList = DataCenter.main.photoList
        
        searchController.searchResultsUpdater = self
        
//        self.navigationItem.searchController = searchController
        mainTable.tableHeaderView = searchController.searchBar
        
    }

}

extension MainViewController:UISearchResultsUpdating, UISearchBarDelegate
{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        if searchText?.count != 0
        {
            filltedList = DataCenter.main.photoList.filter { (photoData) -> Bool in
                return photoData.title.contains(searchText!)
            }
        }else
        {
            filltedList = DataCenter.main.photoList
        }
        
        mainTable.reloadData()
    }
    
}



extension MainViewController:UITableViewDataSource, UITableViewDelegate, PhotoTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filltedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell                
        cell.cellData = filltedList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func didSelectedLikeCell(_ cell: PhotoTableViewCell) {
        if let selectedCell = selectedLikeCell
        {
            if cell === selectedCell
            {
                cell.cellData!.isLike = false
                self.selectedLikeCell = nil
            }else
            {
                selectedCell.cellData!.isLike = false
                DataCenter.main.updatePhotoData(new: selectedCell.cellData!)
                cell.cellData!.isLike = true
                self.selectedLikeCell = cell
            }
        }else
        {
            cell.cellData!.isLike = true
            self.selectedLikeCell = cell
        }
        //저장 & 동기화
        DataCenter.main.likePhotoData = cell.cellData
    }
    
}

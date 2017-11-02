//
//  ExploreViewController.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    struct TableViewConstants {
        static let tableViewCellIdentifier = "searchResultsCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var allResults = [ExploreDataModel]()
    lazy var visibleResults: [ExploreDataModel] = self.allResults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allResults = DataCenter.mainCenter.exploreDataList
    
        // Create the search results view controller and use it for the `UISearchController`.
        let searchResultsController = storyboard!.instantiateViewController(withIdentifier: SearchResultsViewController.StoryboardConstants.identifier) as! SearchResultsViewController
        // Create the search controller and make it perform the results updating.
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.hidesNavigationBarDuringPresentation = false
        
        /*
         Configure the search controller's search bar. For more information on
         how to configure search bars, see the "Search Bar" group under "Search".
         */
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        
        // Include the search bar within the navigation bar.
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    /// A `nil` / empty filter string means show all results. Otherwise, show only results containing the filter.
    var filterString: String? = nil {
        didSet {
            if filterString == nil || filterString!.isEmpty {
                visibleResults = allResults
            }
            else {
                // Filter the results using a predicate based on the filter string.
                // let filterPredicate = NSPredicate(format: "self contains[c] %@", argumentArray: [filterString!])
                // visibleResults = allResults.filter { filterPredicate.evaluate(with: $0) }
                visibleResults = allResults
            }
            tableView.reloadData()
        }
    }
   
}

/*UITableViewDataSource*/
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trending Subscriptions"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.tableViewCellIdentifier, for: indexPath)
        cell.imageView?.frame = CGRect(x: 8, y: 8, width: 30, height: 30)
        cell.textLabel?.text = visibleResults[indexPath.row].itemName
        cell.detailTextLabel?.text = visibleResults[indexPath.row].category
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}


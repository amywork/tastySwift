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
        static let tableViewCellIdentifier = "SearchResultsCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    lazy var allResults = DataCenter.mainCenter.exploreDataList
    lazy var visibleResults: [ExploreDataModel] = self.allResults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create the search results view controller and use it for the `UISearchController`.
        let searchResultsController = storyboard!.instantiateViewController(withIdentifier: SearchResultsViewController.StoryboardConstants.identifier) as! SearchResultsViewController
        // Create the search controller and make it perform the results updating.
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = NSLocalizedString("Search", comment: "services")
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
                let filterPredicate = NSPredicate(format: "self contains[c] %@", argumentArray: [filterString!])
                var list:[String] = []
                for result in allResults {
                    let name = result.itemName
                    list.append(name)
                }
                list = list.filter { filterPredicate.evaluate(with: $0) }
                var lastArr: [ExploreDataModel] = []
                for name in list {
                    for data in visibleResults {
                        if data.itemName == name {
                            lastArr.append(data)
                        }
                    }
                }
                visibleResults = lastArr
            }
            tableView.reloadData()
        }
    }

}

/*UITableViewDataSource*/
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trending Now"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.tableViewCellIdentifier, for: indexPath) as! SearchResultsCell
        cell.data = visibleResults[indexPath.row]
        return cell
    }

}


//
//  SearchResultsViewController.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 02/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SearchResultsViewController: ExploreViewController, UISearchResultsUpdating  {
    // MARK: - Types
  
    struct StoryboardConstants {
        static let identifier = "SearchResultsViewControllerStoryboardIdentifier"
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        /*
         `updateSearchResultsForSearchController(_:)` is called when the controller is
         being dismissed to allow those who are using the controller they are search
         as the results controller a chance to reset their state. No need to update
         anything if we're being dismissed.
         */
        guard searchController.isActive else { return }
        filterString = searchController.searchBar.text
    }
}

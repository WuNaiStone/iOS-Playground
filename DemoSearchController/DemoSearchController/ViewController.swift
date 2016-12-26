//
//  ViewController.swift
//  DemoSearchController
//
//  Created by Chris Hu on 16/12/26.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableView: UITableView!
    
    var searchController: UISearchController!
    
    var cells = [String]()
    var filteredCells = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100 {
            cells.append("Cell - \(i)")
        }
        
        initTableView()
        
        initSearchController()
    }

    override var prefersStatusBarHidden: Bool { return true }
    
    
    func initTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredCells.count
        } else {
            return cells.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if searchController.isActive {
            cell.textLabel?.text = filteredCells[indexPath.item]
        } else {
            cell.textLabel?.text = cells[indexPath.item]
        }
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            filteredCells = cells
        } else {
            filteredCells = cells.filter { (str) -> Bool in
                str.contains(searchController.searchBar.text!)
            }
        }
        tableView.reloadData()
    }
}


extension ViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
    
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
    
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
    
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    
    }
    
    func presentSearchController(_ searchController: UISearchController) {
    
    }
}


extension ViewController: UISearchBarDelegate {
    // func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
    
    // func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
    
    // func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool // return NO to not resign first responder
    
    // func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    // func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) // called when keyboard search button pressed 
    {
        print("searchBarSearchButtonClicked")
    }
    
    // func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) // called when bookmark button pressed
    
    // func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
    
    // func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) // called when search results button pressed
    
    // func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
}





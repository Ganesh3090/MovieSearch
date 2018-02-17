//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchViewController: MSBaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var serviceFetcher = MSServiceFetcher()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTableView()
        self.setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = String(localizedKey: "Search Movies")
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        
        // Setup the Scope Bar
        self.searchController.searchBar.delegate = self
    }
    
    private func setUpTableView() {
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: MovieSearchTableViewCell.className, bundle: nil),
                                forCellReuseIdentifier: MovieSearchTableViewCell.className)
    }
}

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.className) as? MovieSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setMoiveDetails(details: MovieDetails(title: "Batman"))
        return cell
    }
}

// MARK: - UISearchBar Delegate

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        let request = MovieSearchRequest(searchKey: searchText, pageNumber: 1)
        
        self.serviceFetcher.fetchSearchResult(request: request, completion: { (movieList) in
            print(movieList ?? "Failed fetching")
        })
    }
}

// MARK: - UISearchResultsUpdating Delegate

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

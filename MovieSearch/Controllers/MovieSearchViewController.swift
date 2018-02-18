//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchViewController: MSBaseViewController {
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var serviceFetcher = MSServiceFetcher()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)

    private var movieResult: [Movie] = []
    
    private var rescentSearches: [String] = []

    private var currentPage = 1

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchRescentSearches()
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
        self.searchController.isActive = true
    }
    
    private func setUpTableView() {
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: MovieSearchTableViewCell.className, bundle: nil),
                                forCellReuseIdentifier: MovieSearchTableViewCell.className)
        self.tableView.register(UINib(nibName: RescentSearchTableViewCell.className, bundle: nil),
                                forCellReuseIdentifier: RescentSearchTableViewCell.className)

    }
    
    private var isSearchBarActive: Bool {
        return self.searchController.isActive
    }
    
    private func fetchRescentSearches() {
        if let rescentSearchList = RescentSearch.allRescentSearches() {
            self.rescentSearches = rescentSearchList
        }
    }
    
    private func fetchSearchResult(searchKey: String, saveResult: Bool) {
        let request = MovieSearchRequest(searchKey: searchKey, pageNumber: self.currentPage)
        
        self.searchController.searchBar.text = nil
        self.searchController.isActive = false
        
        self.activityIndicatorView.startAnimating()
        self.movieResult.removeAll()

        self.serviceFetcher.fetchSearchResult(request: request, completion: { (result) in
            self.activityIndicatorView.stopAnimating()
            if let movieList = result?.results {
                self.movieResult = movieList
                if saveResult {
                    RescentSearch.saveResult(result: searchKey)
                }
                self.tableView.reloadData()
            }
        })
    }
}

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isSearchBarActive ? self.rescentSearches.count : self.movieResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !self.isSearchBarActive else {
            return self.rescentSearchCell(atIndexPath: indexPath)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.className) as? MovieSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setMoiveDetails(details: self.movieResult[indexPath.row])
        return cell
    }
    
    private func rescentSearchCell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.className) as? RescentSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.searchTitle = self.rescentSearches[indexPath.row]
        
        return cell
    }
}

extension MovieSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.isSearchBarActive else { return }
        
        self.fetchSearchResult(searchKey: self.rescentSearches[indexPath.row], saveResult: false)
    }
}

// MARK: - UISearchBar Delegate

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.fetchRescentSearches()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        self.fetchSearchResult(searchKey: searchText, saveResult: true)
    }
}

// MARK: - UISearchResultsUpdating Delegate

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

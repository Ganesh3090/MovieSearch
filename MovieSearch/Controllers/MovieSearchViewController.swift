//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MovieSearchViewController: MSBaseViewController {
    
    // MARK: - Variables

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.contentInset = UIEdgeInsetsMake(16.0, 0.0, 16.0, 0.0)
        }
    }
    
    private var isSearchInProgress = false {
        didSet {
            if self.isSearchInProgress {
                self.tableView.tableFooterView = self.refreshControl
            } else {
                self.tableView.tableFooterView = nil
            }
        }
    }
    
    @IBOutlet private var refreshControl: MSRefeshControl! {
        didSet {
            var footerFrame = self.refreshControl.frame
            footerFrame.size.height = self.refreshControl.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            self.refreshControl.frame = footerFrame
        }
    }
    
    private lazy var serviceFetcher = MSServiceFetcher()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchRescentSearches()
        self.setUpTableView()
        self.setUpSearchBar()
        
        self.tableView.tableFooterView = nil
    }
    
    // MARK: - Methods

    private func setUpSearchBar() {
        // Setup the Search Controller
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = String(localizedKey: "MOVIE_SEARCH")
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.titleView = self.searchController.searchBar
        
        // Setup the Scope Bar
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    private func setUpTableView() {
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: MovieSearchTableViewCell.className, bundle: nil),
                                forCellReuseIdentifier: MovieSearchTableViewCell.className)
        self.tableView.register(UINib(nibName: RescentSearchTableViewCell.className, bundle: nil),
                                forCellReuseIdentifier: RescentSearchTableViewCell.className)
        
    }
    
    private var isSearchBarActive: Bool = false
    
    private func fetchRescentSearches() {
        if let rescentSearchList = RescentSearch.allRescentSearches() {
            MovieSearchManager.shared.rescentSearches = rescentSearchList
        }
    }
    
    private func fetchSearchResult(searchKey: String, saveResult: Bool, isBottomRefresh: Bool) {
        
        let page = isBottomRefresh ? MovieSearchManager.shared.currentPage + 1 : MovieSearchManager.shared.currentPage
        
        let request = MovieSearchRequest(searchKey: searchKey,
                                         pageNumber: page)
        
        self.searchController.searchBar.text = nil
        self.searchController.isActive = false

        if !isBottomRefresh {
            MovieSearchManager.shared.resetSearchResult()
        }
        
        self.isSearchInProgress = true
        
        MovieSearchManager.shared.currentSearchText = searchKey
        
        self.serviceFetcher.fetchSearchResult(request: request, completion: { (result) in
            self.isSearchInProgress = false
            if isBottomRefresh {
                if let newResult = result {
                    MovieSearchManager.shared.addSearchResult(searchResult: newResult)
                }
            } else {
                MovieSearchManager.shared.searchResult = result
                if MovieSearchManager.shared.searchResult?.statusCode != nil {
                    self.showAlert(title: String(localizedKey: "SOMETHING_WENT_WRONG"),
                                   message: String(localizedKey: "INVALID_API_KEY_MESSAGE"))
                } else if MovieSearchManager.shared.movieResult.count == 0 {
                    self.showAlert(title: String(localizedKey: "SOMETHING_WENT_WRONG"),
                                   message: String(localizedKey: "INVALID_OR_NO_RESPONSE_MESSAGE") + searchKey)
                } else if saveResult {
                    RescentSearch.saveResult(result: searchKey)
                }
            }
            self.tableView.reloadData()
        })
    }
}

// MARK: - UITableView DataSource

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isSearchBarActive ? MovieSearchManager.shared.rescentSearches.count : MovieSearchManager.shared.movieResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !self.isSearchBarActive else {
            return self.rescentSearchCell(atIndexPath: indexPath)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.className) as? MovieSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setMoiveDetails(details: MovieSearchManager.shared.movieResult[indexPath.row])
        return cell
    }
    
    private func rescentSearchCell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RescentSearchTableViewCell.className) as? RescentSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.searchTitle = MovieSearchManager.shared.rescentSearches[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableView Delegate

extension MovieSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.isSearchBarActive else { return }
        
        self.fetchSearchResult(searchKey: MovieSearchManager.shared.rescentSearches[indexPath.row],
                               saveResult: false,
                               isBottomRefresh: false)
    }
}

// MARK: - UIScrollView Delegate

extension MovieSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height == scrollView.contentSize.height {
            if !self.isSearchInProgress && MovieSearchManager.shared.nextPageAvaiable() {
                self.fetchSearchResult(searchKey: MovieSearchManager.shared.currentSearchText,
                                       saveResult: false,
                                       isBottomRefresh: true)
            }
        }
    }
}

// MARK: - UISearchBar Delegate

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearchBarActive = true
        self.fetchRescentSearches()
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearchBarActive = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        self.fetchSearchResult(searchKey: searchText,
                               saveResult: true,
                               isBottomRefresh: false)
    }
}

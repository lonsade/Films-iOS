//
//  SearchViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.tintColor = .FSearchTextColor
            searchBar.placeholder = "Search"
            searchBar.barTintColor = .FSearchTextFieldBackgroundColor
            
            
        }
    }

    @IBOutlet weak var resultsTableView: UITableView! {
        didSet {

            resultsTableView.contentInset.top = 16

        }
    }

    func customize() {
        view.backgroundColor = .FMainBackgroundColor
    }

    var presenter: SearchFilmsPresenterInput!
    var router: SearchFilmsRoutingInput!
    var displayManager: SearchFilmsDisplayManagerOutput! {
        didSet {
            displayManager.searchFilmsTableView = resultsTableView
            displayManager.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customize()

        SearchAssembly.instance().inject(into: self)

        router.viewController = self

        presenter.setSearchFilms(onText: "Age")
    }

}

extension SearchViewController: SearchFilmsDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

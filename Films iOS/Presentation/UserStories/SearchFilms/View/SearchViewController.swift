//
//  SearchViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    private let searchController = UISearchController(searchResultsController: nil)

    // Для оптимизации поиска
    var timer: Timer = Timer()

    @IBOutlet weak var resultsTableView: UITableView! {
        didSet {
            resultsTableView.contentInsetAdjustmentBehavior = .never
        }
    }

    func customize() {
        view.backgroundColor = .FMainBackgroundColor
        navigationController?.navigationBar.tintColor = .FTitleTextColor
    }

    var presenter: SearchFilmsPresenterInput!
    var router: SearchFilmsRoutingInput!
    var displayManager: SearchFilmsDisplayManagerOutput! {
        didSet {
            displayManager.searchFilmsTableView = resultsTableView
            displayManager.delegate = self
        }
    }

    func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .FSearchTextColor

        //SearchBar Text
        guard let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField else {
            return assertionFailure("Invalid TextField key of searchBar")
        }
        textFieldInsideSearchBar.textColor = .FSearchTextColor
        textFieldInsideSearchBar.font = .FSearchPlaceholder
        textFieldInsideSearchBar.backgroundColor = .FSearchTextFieldBackgroundColor
        textFieldInsideSearchBar.autocapitalizationType = .none

        // Clear backgroundColor
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
        for view in searchController.searchBar.subviews {
            for subview in view.subviews {
                if subview.isKind(of: UISearchBarBackground) {
                    subview.alpha = 0
                }
            }
        }

        extendedLayoutIncludesOpaqueBars = true

        resultsTableView.tableHeaderView = searchController.searchBar

        searchController.searchBar.addBorder(toSide: .bottom, withColor: UIColor.FHRColor.cgColor, andThickness: 1)

        definesPresentationContext = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customize()
        setSearchBar()

        SearchAssembly.instance().inject(into: self)

        router.viewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = L10n.Movies.navigationTitle
    }

}

extension SearchViewController: UISearchResultsUpdating {

    @objc
    func load() {
        if let text = timer.userInfo as? String {
            presenter.setSearchFilms(onText: text)
        }
        timer.invalidate()
    }

    func updateSearchResults(for searchController: UISearchController) {
        timer.invalidate()
        if let text = searchController.searchBar.text, !text.isEmpty {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(load), userInfo: text, repeats: false)
        }
    }
}

extension SearchViewController: SearchFilmsDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

private extension UIView {

    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)

    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
}

//
//  SearchViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.tintColor = .FSearchTextColor
            searchBar.placeholder = "Search"
            searchBar.barTintColor = .FSearchTextFieldBackgroundColor
        }
    }

//    
//    
//    @IBOutlet weak var searchTextField: UITextField! {
//        didSet {
//            searchTextField.layer.cornerRadius = 10
//            searchTextField.backgroundColor = .FSearchTextFieldBackgroundColor
//            searchTextField.font = .FSearchPlaceholder
//            searchTextField.textColor = .FSearchTextColor
//            searchTextField.attributedPlaceholder = NSAttributedString(
//                string: "Search",
//                attributes: [.foregroundColor: UIColor.FSearchTextColor]
//            )
//
//        }
//    }
    @IBOutlet weak var resultsTableView: UITableView!

    func customize() {
        view.backgroundColor = .FMainBackgroundColor
    }

    var presenter: SearchFilmsPresenterInput!
    var displayManager: SearchFilmsDisplayManagerOutput! {
        didSet {
            displayManager.searchFilmsTableView = resultsTableView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customize()

        SearchAssembly.instance().inject(into: self)

        presenter.setSearchFilms(onText: "Age")
    }

}

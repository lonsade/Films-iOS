//
//  SearchViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.layer.cornerRadius = 10
            searchTextField.backgroundColor = .FSearchTextFieldBackgroundColor
            searchTextField.font = .FSearchPlaceholder
            searchTextField.textColor = .FSearchTextColor
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [.foregroundColor: UIColor.FSearchTextColor]
            )

            // временно 

            searchTextField.setLeftPaddingPoints(30)
            searchTextField.setRightPaddingPoints(10)

        }
    }
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

        SearchViewControllerAssembly.instance().inject(into: self)

        presenter.setSearchFilms(onText: "Age")
    }

}

private extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

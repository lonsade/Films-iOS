//
//  SearchViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    // Для оптимизации поиска
    var timer: Timer = Timer()

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.layer.cornerRadius = 10
            searchTextField.backgroundColor = .FSearchTextFieldBackgroundColor
            searchTextField.textColor = .FTitleTextColor
            searchTextField.tintColor = .FTitleTextColor
            searchTextField.font = .FSearchPlaceholder
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [.foregroundColor: UIColor.FSearchTextColor]
            )
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 36))
            let image = UIImageView(image: Asset.searchGlyphOnLight.image)
            image.frame.origin = CGPoint(x: 4, y: 6)
            paddingView.addSubview(image)
            searchTextField.leftView = paddingView
            searchTextField.leftViewMode = .always

        }
    }

    @IBOutlet weak var resultsTableView: UITableView! {
        didSet {
            resultsTableView.contentInsetAdjustmentBehavior = .never
            resultsTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
            displayManager.searchFilmsTableView = resultsTableView
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
            displayManager.delegate = self
            displayManager.controller = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        SearchAssembly.instance().inject(into: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customize()

        router.viewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = Bundle.main.object(forInfoDictionaryKey: "AppName") as? String
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        timer.invalidate()
        if let text = sender.text {
            if !text.isEmpty {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(load), userInfo: text, repeats: false)
            } else {
                presenter.clear()
                timer.invalidate()
            }
        }
    }

    @objc
    func load() {
        if let text = timer.userInfo as? String {
            presenter.setSearchFilms(onText: text) { [weak self] error in
                if error != nil {
                    self?.callAlertError()
                }
            }
        }
        timer.invalidate()
    }
}

extension SearchViewController: SearchFilmsDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id, withType: presenter.type)
    }
}

//
//  MenuViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 22.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit
import InteractiveSideMenu

/**
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class SampleMenuViewController: MenuViewController, Storyboardable {

    @IBOutlet weak var homeImageView: UIImageView! {
        didSet {
            homeImageView.image = Asset.home.image
        }
    }
    @IBOutlet weak var moviesImageView: UIImageView! {
        didSet {
            moviesImageView.image = Asset.movie.image
        }
    }
    @IBOutlet weak var tvImageView: UIImageView! {
        didSet {
            tvImageView.image = Asset.tvShows.image
        }
    }
    @IBOutlet weak var favoritesImageView: UIImageView! {
        didSet {
            favoritesImageView.image = Asset.favorites.image
        }
    }

    private func customize(label: UILabel, text: String) {
        label.textColor = UIColor.FTitleTextColor
        label.font = UIFont.FMenuItem
        label.text = text
    }

    @IBOutlet weak var homeLabel: UILabel! {
        didSet {
            customize(label: homeLabel, text: L10n.Menu.home)
        }
    }
    @IBOutlet weak var moviesLabel: UILabel! {
        didSet {
            customize(label: moviesLabel, text: L10n.Menu.movies)
        }
    }
    @IBOutlet weak var tvLabel: UILabel! {
        didSet {
            customize(label: tvLabel, text: L10n.Menu.tvShow)
        }
    }
    @IBOutlet weak var favoritesLabel: UILabel! {
        didSet {
            customize(label: favoritesLabel, text: L10n.Menu.favorites)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: Asset.group2.image)
    }
}

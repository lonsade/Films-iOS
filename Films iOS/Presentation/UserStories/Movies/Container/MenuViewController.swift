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
            homeImageView.image = #imageLiteral(resourceName: "home")
        }
    }
    @IBOutlet weak var moviesImageView: UIImageView! {
        didSet {
            moviesImageView.image = #imageLiteral(resourceName: "movie")
        }
    }
    @IBOutlet weak var tvImageView: UIImageView! {
        didSet {
            tvImageView.image = #imageLiteral(resourceName: "tvShows")
        }
    }
    @IBOutlet weak var favoritesImageView: UIImageView! {
        didSet {
            favoritesImageView.image = #imageLiteral(resourceName: "favorites")
        }
    }

    private func customize(label: UILabel, text: String) {
        label.textColor = UIColor.FTitleTextColor
        label.font = UIFont.FMenuItem
        label.text = text
    }

    @IBOutlet weak var homeLabel: UILabel! {
        didSet {
            customize(label: homeLabel, text: "HOME")
        }
    }
    @IBOutlet weak var moviesLabel: UILabel! {
        didSet {
            customize(label: moviesLabel, text: "MOVIES")
        }
    }
    @IBOutlet weak var tvLabel: UILabel! {
        didSet {
            customize(label: tvLabel, text: "TV SHOWS")
        }
    }
    @IBOutlet weak var favoritesLabel: UILabel! {
        didSet {
            customize(label: favoritesLabel, text: "FAVORITES")
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
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "group2"))
    }
}

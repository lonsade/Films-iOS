//
//  HostViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 23.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit
import InteractiveSideMenu

/**
 HostViewController is container view controller, contains menu controller and the list of relevant view controllers.
 Responsible for creating and selecting menu items content controlers.
 Has opportunity to show/hide side menu.
 */

class HostViewController: MenuContainerViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var options = TransitionOptions()
        options.duration = 0.4
        options.visibleContentWidth = view.bounds.width / 8
        //options.contentScale = 0.8

        currentItemOptions.cornerRadius = 8
        currentItemOptions.shadow = .init(color: .black, opacity: 0.71, offset: CGSize(width: 0, height: 0), radius: 30)

        self.transitionOptions = options

        menuViewController = SampleMenuViewController.storyboardViewController()
        contentViewControllers = contentControllers()
        selectContentViewController(contentViewControllers.first!)
    }

    private func contentControllers() -> [UIViewController] {
        let filmsController = MainViewController.storyboardNavigationController()

        return [filmsController]
    }
}

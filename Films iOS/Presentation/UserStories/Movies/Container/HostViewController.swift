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

        let screenSize: CGRect = UIScreen.main.bounds
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 8)

        // Instantiate menu view controller by identifier
        self.menuViewController = SampleMenuViewController.storyboardViewController()

        // Gather content items controllers
        self.contentViewControllers = contentControllers()

        // Select initial content controller. It's needed even if the first view controller should be selected.
        self.selectContentViewController(contentViewControllers.first!)

        self.currentItemOptions.cornerRadius = 8

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Options to customize menu transition animation.
        var options = TransitionOptions()

        // Animation duration
        options.duration = size.width < size.height ? 0.4 : 0.6

        // Part of item content remaining visible on right when menu is shown
        options.visibleContentWidth = size.width / 6
        self.transitionOptions = options
    }

    private func contentControllers() -> [UIViewController] {
        let filmsController = MainViewController.storyboardNavigationController()

        return [filmsController]
    }
}

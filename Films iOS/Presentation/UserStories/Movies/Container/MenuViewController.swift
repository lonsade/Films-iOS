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

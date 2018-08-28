//
//  Storyboardable.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 22.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        return String(describing: self)
    }

    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)

        guard let viewc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }

        return viewc
    }

    static func storyboardNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)

        guard let navc = storyboard.instantiateInitialViewController() as? UINavigationController else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }

        return navc
    }

    static func storyboardTabBarController() -> UITabBarController {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)

        guard let tabc = storyboard.instantiateInitialViewController() as? UITabBarController else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }

        return tabc
    }
}

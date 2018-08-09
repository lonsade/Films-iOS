//
//  BaseAboutArtistViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class BaseAboutArtistPageController: UIPageViewController {

    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "bio"),
            self.getViewController(withIdentifier: "films")
        ]
    }()

    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "artist", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    override func viewDidLoad() {

        dataSource = self

        guard let firstPage = pages.first else {
            fatalError("Could not get view controller in aboutArtist")
        }

        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }

}

extension BaseAboutArtistPageController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {

        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 && pages.count > previousIndex else { return nil }
        return pages[previousIndex]

    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {

        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard
            nextIndex < pages.count &&
                pages.count > nextIndex
            else { return nil }
        return pages[nextIndex]

    }

}

//
//  AboutFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutFilmViewController: UIViewController {

    /*
        Сделал свой массив вьюшек табов,
        потому что во время изменения состояния сегмент контроля
        менялся и исходный массив tabs.subviews
    */

    private lazy var tabViews: [UIView] = {
        var tabsV = [UIView]()
        for tab in self.tabs.subviews {
            tabsV.append(tab)
        }
        return tabsV
    }()

    private func setActiveTintColorOnItem(of index: Int) {
        for tabIndex in tabViews.indices {
            if tabIndex == index {
                tabViews[tabIndex].tintColor = UIColor.FActiveTextColor
            } else {
                tabViews[tabIndex].tintColor = UIColor.FHRColor
            }
        }
    }

    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "film", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    private var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }

    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "aboutFilm"),
            self.getViewController(withIdentifier: "cast"),
            self.getViewController(withIdentifier: "review")
        ]
    }()

    /*Кастомизация линии под сегмент контролем*/
    @IBOutlet weak var lineUnderTabs: UIView! {
        didSet {
            lineUnderTabs.backgroundColor = UIColor.FHRColor
        }
    }

    @IBOutlet weak var tdbBarForFilm: UIStackView! {
        didSet {
            tdbBarForFilm.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            tdbBarForFilm.isLayoutMarginsRelativeArrangement = true
        }
    }

    @IBOutlet weak var tabs: UISegmentedControl! {
        didSet {
            tabs.translatesAutoresizingMaskIntoConstraints = false
            //tabs.tintColor = UIColor.FHRColor
            tabs.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.FInactiveTabTitleColorAboutFilm], for: .normal)
            tabs.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.FActiveTabTitleColorAboutFilm], for: .selected)

            setActiveTintColorOnItem(of: tabs.selectedSegmentIndex)
        }
    }

    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        setActiveTintColorOnItem(of: sender.selectedSegmentIndex)
    }

    private func costomize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        costomize()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pvc = segue.destination as? UIPageViewController {
            pageViewController = pvc
            if let firstVC = pages.first {
                pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
    }

}

extension AboutFilmViewController: UIPageViewControllerDelegate {

}

extension AboutFilmViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
        ) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
        ) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

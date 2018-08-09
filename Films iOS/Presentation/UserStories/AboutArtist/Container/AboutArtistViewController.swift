//
//  AboutArtistViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutArtistViewController: UIViewController {

    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "artist", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    private var pageViewController: UIPageViewController! {
        didSet {
            pageViewController.dataSource = self
            pageViewController.delegate = self
        }
    }

    lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "artistPage0"),
            self.getViewController(withIdentifier: "artistPage1")
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

extension AboutArtistViewController: UIPageViewControllerDelegate {

}

extension AboutArtistViewController: UIPageViewControllerDataSource {

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

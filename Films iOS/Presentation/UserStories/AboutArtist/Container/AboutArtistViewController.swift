//
//  AboutArtistViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutArtistViewController: UIViewController {

    private let pages = ["bio", "films"]
    private let storybordName = "artist"

    @IBOutlet weak var tdbBarForFilm: UIStackView! {
        didSet {
            tdbBarForFilm.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            tdbBarForFilm.isLayoutMarginsRelativeArrangement = true
        }
    }

    private var pageViewController: BasePageViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageView = segue.destination as? BasePageViewController {
            pageView.set(pages: pages, storyboardName: storybordName)

            pageViewController = pageView

            guard let firstPage = pageView.viewPages.first else {
                fatalError("Could not put first page)")
            }

            pageView.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)

            pageView.pageDelegate = self
        }
    }

    @IBOutlet weak var tabsSegmentControl: FSegmentControl! {
        didSet {
            tabsSegmentControl.delegate = self
        }
    }

    private func costomize() {
        view.backgroundColor = UIColor.FMainBackgroundColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        costomize()
    }

}

//Синхронизация смены страницы с изменением активной вкладки
extension AboutArtistViewController: BasePageViewControllerDelegate {
    func pageWasChanged(at index: Int) {
        tabsSegmentControl.selectedSegmentIndex = index
    }
}

//Синхронизация изменения активной вкладки с сменой страницы
extension AboutArtistViewController: FSegmentControlDelegate {
    func itemWasSelected(at index: Int) {
        var direction: UIPageViewControllerNavigationDirection = .forward
        if let prevIndex = tabsSegmentControl.prevSelectedIndex, prevIndex > index {
            direction = .reverse
        }
        pageViewController?.setViewControllers([(pageViewController?.viewPages[index])!], direction: direction, animated: true, completion: nil)
    }
}

//
//  AboutFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol ModuleInputProvider {
    var moduleInput: ModuleInput! { get }
}

protocol AboutFilmInput: ModuleInput {
    var id: Int? { get }
    func set(id: Int)
}

class AboutFilmPresenter: AboutFilmInput {

    var id: Int?

    func set(id: Int) {
        self.id = id
    }
}

final class AboutFilmViewController: UIViewController, ModuleInputProvider {

    var moduleInput: ModuleInput!

    private let pages = ["page0", "page1", "page2"]
    private let storybordName = "film"

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
        navigationController?.navigationBar.tintColor = .FTitleTextColor
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        AboutFilmViewAssembly.instance().inject(into: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Film"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Для изменения кнопки back
        NotificationCenter.default.addObserver(self, selector: #selector(filmWasSelected), name: .beforeSegueDone, object: nil)
        costomize()
    }

    // Для изменения кнопки back
    @objc
    private func filmWasSelected() {
        navigationItem.title = nil
    }

}

//Синхронизация смены страницы с изменением активной вкладки
extension AboutFilmViewController: BasePageViewControllerDelegate {
    func pageWasChanged(at index: Int) {
        tabsSegmentControl.selectedSegmentIndex = index
    }
}

//Синхронизация изменения активной вкладки с сменой страницы
extension AboutFilmViewController: FSegmentControlDelegate {
    func itemWasSelected(at index: Int) {
        var direction: UIPageViewControllerNavigationDirection = .forward
        if let prevIndex = tabsSegmentControl.prevSelectedIndex, prevIndex > index {
            direction = .reverse
        }
        pageViewController?.setViewControllers([(pageViewController?.viewPages[index])!], direction: direction, animated: true, completion: nil)
    }
}

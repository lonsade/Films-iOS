//
//  AboutFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 06.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class AboutFilmViewController: BaseViewController {

    private let pages = [L10n.AboutFilm.page1, L10n.AboutFilm.page2, L10n.AboutFilm.page3]
    private let storybordName = L10n.AboutFilm.storybordName
    private var firstPage: BaseViewController!

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
            self.firstPage = firstPage as? BaseViewController

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
        AboutFilmContainerAssembly.instance().inject(into: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        costomize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let moduleInput = moduleInput as? AboutFilmInput else {
            return assertionFailure("\(String(describing: ModuleInput.self)) could not cast to \(String(describing: AboutFilmInput.self))")
        }
        navigationItem.title = moduleInput.type == 0 ? L10n.Movies.navigationTitle : L10n.AboutTv.navigationTitle
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

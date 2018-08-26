//
//  AboutArtistViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class AboutArtistViewController: UIViewController, ModuleInputProvider {

    var moduleInput: ModuleInput!

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
        // Для изменения кнопки back
        NotificationCenter.default.addObserver(self, selector: #selector(filmWasSelected), name: .beforeSegueDone, object: nil)
        costomize()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        AboutArtistContainerAssembly.instance().inject(into: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Artist"
    }

    // Для изменения кнопки back
    @objc
    private func filmWasSelected() {
        navigationItem.title = nil
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

        guard let validIndex = pageViewController?.viewPages[index] else {
            fatalError("Invalid index: \(index)")
        }

        pageViewController?.setViewControllers([validIndex], direction: direction, animated: true, completion: nil)
    }
}

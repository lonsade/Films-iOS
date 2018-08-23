//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit
import InteractiveSideMenu

final class MainViewController: UIViewController, SideMenuItemContent, Storyboardable {

    private let storybordName = "MainViewController"

    private var prevSelectedCell: TabNameCollectionViewCell?

    private var firstPage: UIViewController!

    var tabNamesPresenter: ITabNamesPresenter!

    var tabDisplayManager: TabDisplayManager! {
        didSet {
            tabDisplayManager.collectionTabNames = self.collectionTabNames
            tabDisplayManager.delegate = self
        }
    }

    @IBAction func showMenu(_ sender: CustomMenuBarButtonItem) {
        showSideMenu()
    }

    @IBOutlet weak var collectionTabNames: UICollectionView!

    /* кастомизация navigationBar и установка главного фона */

    @IBOutlet weak var navigationBar: UINavigationItem!

    func customize() {
        view.backgroundColor = UIColor.FMainBackgroundColor

        // Прозрачный navbar

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.FTitleTextColor,
            .font: UIFont.FAppName
        ]
    }

    private var pageViewController: BaseMainPageViewController!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageView = segue.destination as? BaseMainPageViewController {
            pageViewController = pageView
        }
    }

    var genresDataSource: ITabNamesDataSourceOutput!

    var filmsPresenter: IFilmsPresenter!

    var filmsDataSource: BaseFilmsDataSourceOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        MainViewAssembly.instance().inject(into: self)
        tabNamesPresenter.setTabNames()
        customize()
        genresDataSource.delegate = self
        filmsDataSource.delegate = self

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    var genres: [TabName]!

}

extension MainViewController: TabNamesDSDelegate {
    func tabNamesWasAdded(names: [TabName]) {
        collectionTabNames?.reloadData()
        self.genres = names
        filmsPresenter.loadPopularFilms(firstly: true)
    }
}

extension MainViewController: TabDisplayManagerDelegate {

    func tabWasSelected(at indexPath: IndexPath) {

        guard let selectedCell = collectionTabNames.cellForItem(at: indexPath) as? TabNameCollectionViewCell
        else { fatalError("Error cell tab name with index: \(indexPath.item)") }

        if let psc = prevSelectedCell {
            psc.changeActive(active: false)
        } else {
            (collectionTabNames.cellForItem(at: IndexPath(item: 1, section: 0)) as? TabNameCollectionViewCell)?.changeActive(active: false)
        }

        selectedCell.changeActive(active: true)

        prevSelectedCell = selectedCell

        // Конфигурирование нового модуля

        let openPage = pageViewController.pagedViewControllers[genres[indexPath.item]]
        pageViewController.configureModule(withName: genres[indexPath.item]) { moduleInput in
            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                fatalError("Could not cust moduleInput to FilmsPresenterInput")
            }
            filmsInput.set(genre: self.genres[indexPath.item])

            // Определение направления анимации смены контроллера и его установка
            guard
                let openPage = openPage,
                let currentPage = self.pageViewController.currentViewController
            else {
                fatalError("Current page or openning page are nil")
            }
            let index = self.pageViewController.viewPages.index(of: currentPage)
            guard let validIndex = index else {
                fatalError("Current page into under range of viewPages")
            }
            let direction: UIPageViewControllerNavigationDirection = (validIndex < indexPath.item) ? .forward : .reverse
            self.pageViewController.setViewControllers([openPage], direction: direction, animated: true, completion: nil)
        }

    }
}

extension MainViewController: BaseMainPageViewControllerDelegate {
    func pageWasChanged(to toIndex: Int, from fromIndex: Int) {
        if let cell = collectionTabNames.cellForItem(at: IndexPath(item: toIndex, section: 0)) as? TabNameCollectionViewCell {
            cell.changeActive(active: true)
        }
        if let cell = collectionTabNames.cellForItem(at: IndexPath(item: fromIndex, section: 0)) as? TabNameCollectionViewCell {
            cell.changeActive(active: false)
        }
    }
}

extension MainViewController: BaseFilmsDataSourceDelegate {
    func baseWasAdd() {
        pageViewController.set(pages: genres, storyboardName: storybordName)
        pageViewController.configureModule(withName: genres[1]) { moduleInput in
            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                fatalError("Could not cust moduleInput to FilmsPresenterInput")
            }
            filmsInput.set(genre: self.genres[1])
        }
        guard let firstPage = pageViewController.pagedViewControllers[genres[1]] else {
            fatalError("Could not put first page)")
        }
        self.firstPage = firstPage
        pageViewController.pageDelegate = self
        pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }
}

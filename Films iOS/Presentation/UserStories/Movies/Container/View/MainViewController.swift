//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit
import InteractiveSideMenu

final class MainViewController: BaseViewController, SideMenuItemContent, Storyboardable {

    private let storybordName = L10n.Movies.storybordName

    private var firstPage: UIViewController!

    var tabNamesPresenter: ITabNamesPresenter!
    var router: MoviesContainerRoutingInput!

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

    override func awakeFromNib() {
        super.awakeFromNib()
//        MoviesContainerAssembly.instance().inject(into: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customize()
//        tabNamesPresenter.setTabNames()
//        genresDataSource.delegate = self
//        router.viewController = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = L10n.Movies.navigationTitle

//        // TODO: надо подумать над переносом этой штуки во viewDidLoad
//        // (пока не получается, потому что используется один модуль контейнер для фильмов и тв шоу)
//
        MoviesContainerAssembly.instance().inject(into: self)
        tabNamesPresenter.setTabNames()
        genresDataSource.delegate = self
        router.viewController = self

        pageViewController.type = self.type
    }

    @IBOutlet weak var searchButton: UIBarButtonItem! {
        didSet {
            searchButton.tintColor = .FTitleTextColor
        }
    }

    var genres: [TabName]!

    @IBAction func doSearch(_ sender: UIBarButtonItem) {
        router.navigateToSearch()
    }
}

extension MainViewController: TabNamesDSDelegate {
    func tabNamesWasAdded(names: [TabName]) {

        self.collectionTabNames.reloadData()
        self.collectionTabNames.layoutIfNeeded()

        self.genres = names

        pageViewController.set(pages: genres, storyboardName: storybordName)
        pageViewController.configureModule(withName: genres[1]) { moduleInput in
            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                fatalError("Could not cust moduleInput to FilmsPresenterInput")
            }
            filmsInput.set(genre: self.genres[1], type: self.type)
        }
        guard let firstPage = pageViewController.pagedViewControllers[genres[1]] else {
            fatalError("Could not put first page)")
        }
        self.firstPage = firstPage
        pageViewController.pageDelegate = self
        pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)

        DispatchQueue.main.async {
            //self.collectionTabNames.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }

    }
}

extension MainViewController: TabDisplayManagerDelegate {

    func tabWasSelected(at indexPath: IndexPath) {

        // Конфигурирование нового модуля

        let openPage = pageViewController.pagedViewControllers[genres[indexPath.item]]
        pageViewController.configureModule(withName: genres[indexPath.item]) { moduleInput in
            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                fatalError("Could not cust moduleInput to FilmsPresenterInput")
            }
            filmsInput.set(genre: self.genres[indexPath.item], type: self.type)

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
            self.pageViewController.setViewControllers([openPage], direction: direction, animated: true) { finished in
                if finished {
                    self.collectionTabNames.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }

        }

    }
}

extension MainViewController: BaseMainPageViewControllerDelegate {
    func pageWasChanged(to toIndex: Int, from fromIndex: Int) {
        self.collectionTabNames.selectItem(at: IndexPath(item: toIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

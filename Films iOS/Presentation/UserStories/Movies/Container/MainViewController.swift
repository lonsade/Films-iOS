//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol MainModuleInput {

}

final class MainViewController: UIViewController {

    private let storybordName = "Main"

    private var prevSelectedCell: TabNameCollectionViewCell?

    private var firstPage: UIViewController!

    var tabNamesPresenter: ITabNamesPresenter!

    var tabDisplayManager: TabDisplayManager! {
        didSet {
            tabDisplayManager.collectionTabNames = self.collectionTabNames
            tabDisplayManager.delegate = self
        }
    }

    @IBOutlet weak var collectionTabNames: UICollectionView!

    /* кастомизация navigationBar и установка главного фона */

    @IBOutlet weak var navigationBar: UINavigationItem!

    func customize() {
        view.backgroundColor = UIColor.FMainBackgroundColor

//        UINavigationBar.appearance().backgroundColor = UIColor.clear

//        navigationController?.navigationBar.barTintColor = UIColor.FMainBackgroundColor

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

}

extension MainViewController: TabNamesDSDelegate {
    func tabNamesWasAdded(names: [TabName]) {
        collectionTabNames?.reloadData()
        filmsPresenter.loadPopularFilms()

        pageViewController.set(pages: names, storyboardName: storybordName)
        pageViewController.configureModule(withName: names[1]) { moduleInput in
            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
                fatalError("Could not cust moduleInput to FilmsPresenterInput")
            }
            filmsInput.set(genre: names[1])
        }
        guard let firstPage = pageViewController.pagedViewControllers[names[1]] else {
            fatalError("Could not put first page)")
        }
        self.firstPage = firstPage
        pageViewController.pageDelegate = self

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

//        guard let tabTitle = selectedCell.tabName.text?.lowercased() else { fatalError("Genres are not loaded") }
//
//        pageViewController.configureModule(withName: tabTitle) { moduleInput in
//            guard let filmsInput = moduleInput as? FilmsPresenterInput else {
//                fatalError("Could not cust moduleInput to FilmsPresenterInput")
//            }
//            filmsInput.set(genre: tabTitle)
//        }

    }
}

extension MainViewController: BasePageViewControllerDelegate {
    func pageWasChanged(at index: Int) {

    }

}

extension MainViewController: BaseFilmsDataSourceDelegate {
    func baseWasAdd() {
        pageViewController.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }
}

//
//  MainViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    private let pages = ["Popular", "in cinema"]
    private let storybordName = "Main"

    private var prevSelectedCell: TabNameCollectionViewCell?

    var tabNamesPresenter: ITabNamesPresenter!

    var tabDisplayManager: TabDisplayManager! {
        didSet {
            tabDisplayManager.collectionTabNames = self.collectionTabNames
            tabDisplayManager.delegate = self
        }
    }

    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.backgroundColor = UIColor.FHRColor
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageView = segue.destination as? BasePageViewController {
            pageView.set(pages: pages, storyboardName: storybordName)
            guard let firstPage = pageView.viewPages.first else {
                fatalError("Could not put first page)")
            }
            pageView.setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MainViewAssembly.instance().inject(into: self)
        tabNamesPresenter.setTabNames()
        customize()
    }

}

extension MainViewController: TabDisplayManagerDelegate {

    func tabWasSelected(at indexPath: IndexPath) {

        guard let selectedCell = collectionTabNames.cellForItem(at: indexPath) as? TabNameCollectionViewCell
            else { fatalError("Error cell tab name with index: \(indexPath.item)") }

        if let psc = prevSelectedCell {
            psc.changeActive(active: false)
        }

        selectedCell.changeActive(active: true)

        prevSelectedCell = selectedCell

    }
}
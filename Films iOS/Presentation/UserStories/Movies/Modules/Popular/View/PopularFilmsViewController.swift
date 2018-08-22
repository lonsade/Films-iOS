//
//  PopularFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class PopularFilmsViewController: BaseViewController {

    @IBOutlet weak var filmCollection: UICollectionView!

    var filmCollectionDisplayManager: BaseMoviesDisplayManager! {
        didSet {
            filmCollectionDisplayManager.delegate = self
            filmCollectionDisplayManager.isSeeAlso = false
        }
    }

    var presenter: IPopularFilmsPresenter!
    var router: MoviesRouting!
    var dataSource: BaseMoviesDataSourceOutput!

    override func awakeFromNib() {
        super.awakeFromNib()
        PopularFilmsViewAssembly.instance().inject(into: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        filmCollectionDisplayManager.collectionFilms = filmCollection
        presenter.setPopularFilms()
        dataSource.filmsDelegate = self
    }

}

extension PopularFilmsViewController: BaseFilmsDataSourceDelegate {
    func baseWasAdd() {
        presenter.setPopularFilms()
        filmCollection.reloadData()
    }
}

extension PopularFilmsViewController: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(withIndex id: Int) {
        router.navigateToAboutFilm(onIndex: id)
    }
}

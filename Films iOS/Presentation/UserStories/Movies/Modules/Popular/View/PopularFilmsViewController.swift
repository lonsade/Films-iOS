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
            filmCollectionDisplayManager.collectionFilms = filmCollection
            filmCollectionDisplayManager.delegate = self
            filmCollectionDisplayManager.isSeeAlso = false
        }
    }

    var presenter: IPopularFilmsPresenter!
    var router: MoviesRouting!

    override func viewDidLoad() {
        super.viewDidLoad()
        PopularFilmsViewAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.setPopularFilms()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AboutFilm" {
            if let aboutFilm = segue.destination as? AboutFilmViewController {

            }

        }
    }

}

extension PopularFilmsViewController: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

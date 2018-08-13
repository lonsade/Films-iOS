//
//  ArtistFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ArtistFilmsViewController: BaseViewController {

    var presenter: IArtistFilmsPresenter!

    var router: ArtistFilmsRouting!

    var artistFilmsDisplayManager: BaseMoviesDisplayManager! {
        didSet {
            artistFilmsDisplayManager.collectionFilms = artistFilmsCollectionView
            artistFilmsDisplayManager.delegate = self
            artistFilmsDisplayManager.isSeeAlso = false
        }
    }

    var artistFilmsDataSource: BaseMoviesDataSourceOutput! {
        didSet {
            artistFilmsDataSource.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FMainBackgroundColor
        ArtistFilmsViewAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.setArtistFilms()
    }

    @IBOutlet weak var artistFilmsCollectionView: UICollectionView!
}

extension ArtistFilmsViewController: BaseMoviesDataSourceDelegate {
    func moviesWereAdd() {
        artistFilmsDisplayManager.collectionFilms?.reloadData()
    }
}

extension ArtistFilmsViewController: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

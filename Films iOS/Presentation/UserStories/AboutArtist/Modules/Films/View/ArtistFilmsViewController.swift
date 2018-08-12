//
//  ArtistFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ArtistFilmsViewController: BaseViewController {

    var artistFilmsPresenter: IArtistFilmsPresenter!

    var moviesRouting: BaseMoviesRoutingProtocol!

    var artistFilmsDisplayManager: BaseMoviesDisplayManager! {
        didSet {
            artistFilmsDisplayManager.collectionFilms = artistFilmsCollectionView
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
        moviesRouting.set(viewController: self)
        artistFilmsPresenter.setArtistFilms()
    }

    @IBOutlet weak var artistFilmsCollectionView: UICollectionView!
}

extension ArtistFilmsViewController: BaseMoviesDataSourceDelegate {
    func moviesWereAdd() {
        artistFilmsDisplayManager.collectionFilms?.reloadData()
    }
}

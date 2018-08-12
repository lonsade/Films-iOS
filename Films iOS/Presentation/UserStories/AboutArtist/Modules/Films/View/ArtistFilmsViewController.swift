//
//  ArtistFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ArtistFilmsViewController: UIViewController {

    var artistFilmsPresenter: IArtistFilmsPresenter!

    var artistFilmsDisplayManager: ArtistFilmsDisplayManager! {
        didSet {
            artistFilmsDisplayManager.collectionFilms = artistFilmsCollectionView
        }
    }

    var artistFilmsDataSource: IArtistFilmsDataSourceOutput! {
        didSet {
            artistFilmsDataSource.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FMainBackgroundColor
        ArtistFilmsViewAssembly.instance().inject(into: self)
        artistFilmsPresenter.setArtistFilms()
    }

    @IBOutlet weak var artistFilmsCollectionView: UICollectionView!
}

extension ArtistFilmsViewController: ArtistFilmsDataSourceDelegate {
    func artistFilmsWereAdd() {
        artistFilmsDisplayManager.collectionFilms?.reloadData()
    }

}

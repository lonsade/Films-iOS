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

    var artistFilmsDisplayManager: ArtistMoviesDisplayManager! {
        didSet {
            artistFilmsDisplayManager.collectionFilms = artistFilmsCollectionView
            artistFilmsDisplayManager.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FMainBackgroundColor
        ArtistFilmsViewAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.loadArtistFilms()
    }

    @IBOutlet weak var artistFilmsCollectionView: UICollectionView!
}

extension ArtistFilmsViewController: ArtistMoviesDisplayManagerDelegate {
    func filmWasSelected(withIndex id: Int) {
        router.navigateToAboutFilm(withId: id)
    }
}

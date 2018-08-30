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

    var router: ArtistFilmsRoutingInput!

    var artistFilmsDisplayManager: ArtistMoviesDisplayManager! {
        didSet {
            artistFilmsDisplayManager.collectionFilms = artistFilmsCollectionView
            artistFilmsDisplayManager.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .FMainBackgroundColor
        ArtistFilmsAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.loadArtistFilms { [weak self] error in
            if error != nil {
                self?.callAlertError()
            }
        }
    }

    @IBOutlet weak var artistFilmsCollectionView: UICollectionView!
}

extension ArtistFilmsViewController: ArtistMoviesDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id, withType: presenter.type)
    }
}

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

    var filmCollectionDisplayManager: FilmCollectionDisplayManager! {
        didSet {
            filmCollectionDisplayManager.collectionFilms = filmCollection
            //filmCollectionDisplayManager.delegate = self
        }
    }

    var popularFilmsPresenter: IPopularFilmsPresenter!

    var moviesRouting: MoviesRoutingProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        PopularFilmsViewAssembly.instance().inject(into: self)
        moviesRouting.set(viewController: self)
        popularFilmsPresenter.setPopularFilms()
    }

}

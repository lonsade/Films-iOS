//
//  PopularFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class PopularFilmsViewController: UIViewController {

    @IBOutlet weak var filmCollection: UICollectionView!

    var filmCollectionDisplayManager: FilmCollectionDisplayManager! {
        didSet {
            filmCollectionDisplayManager.collectionFilms = filmCollection
            //filmCollectionDisplayManager.delegate = self
        }
    }

    var popularFilmsPresenter: IPopularFilmsPresenter!

    var moviesRouting: MoviesRouting!

    override func viewDidLoad() {
        super.viewDidLoad()
        PopularFilmsViewAssembly.instance().inject(into: self)
        popularFilmsPresenter.setPopularFilms()
    }

}

//extension PopularFilmsViewController: FilmCollectionDisplayManagerDelegate {
//    func filmWasSelected(at indexPath: IndexPath) {
//        return
//    }
//
//}

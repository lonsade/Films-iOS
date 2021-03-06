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
            filmCollectionDisplayManager.controller = self
        }
    }

    var presenter: IPopularFilmsPresenter!
    var router: MoviesRouting!

    override func awakeFromNib() {
        super.awakeFromNib()
        ListOfMoviesAssembly.instance().inject(into: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        filmCollectionDisplayManager.collectionFilms = filmCollection
        presenter.setFilms { error in
            if error != nil {
                // alert
                self.callAlertError()
            }
        }
        // для передачи в pageController
        type = presenter.type
    }

}

extension PopularFilmsViewController: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(onId: id, withType: self.presenter.type)
    }
}

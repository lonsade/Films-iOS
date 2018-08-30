//
//  InfoFilmViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class InfoFilmViewController: BaseViewController {

    var infoFilmDisplayManager: InfoFilmDisplayManager! {
        didSet {
            infoFilmDisplayManager.infoFilmCollectionView = aboutFilmCollectionView
            infoFilmDisplayManager.delegate = self
            infoFilmDisplayManager.controller = self
        }
    }

    var router: InfoRouting!
    var presenter: IDetailsFilmPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        FilmInfoAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.setDetailsFilm { [weak self] error in
            if error != nil {
                self?.callAlertError()
                self?.view.isHidden = true
            }
        }
        presenter.setGallery { [weak self] error in
            if error != nil {
                self?.callAlertError()
            }
        }
        presenter.setSimilar { [weak self] error in
            if error != nil {
                self?.callAlertError()
            }
        }
    }

    @IBOutlet weak var aboutFilmCollectionView: UICollectionView!

}

extension InfoFilmViewController: InfoFilmDisplayManagerDelegate {
    func filmWasSelected(withId id: Int) {
        router.navigateToAboutFilm(withId: id, withType: presenter.type)
    }
}

//
//  CastViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class CastViewController: BaseViewController {

    @IBOutlet weak var collectionCast: UICollectionView!

    var castDisplayManager: CastDisplayManager! {
        didSet {
            castDisplayManager.collectionCast = self.collectionCast
            castDisplayManager.delegate = self
        }
    }

    var router: CastRouting!
    var presenter: ICastFilmPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        CastViewAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.setCredits()
    }

}

extension CastViewController: FilmCastCollectionDisplayManager {
    func castWasSelected(withId id: Int) {
        router.navigateToAboutArtist(withId: id)
    }
}

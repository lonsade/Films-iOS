//
//  CastViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class CastViewController: UIViewController {

    @IBOutlet weak var collectionCast: UICollectionView!

    var castDisplayManager: CastDisplayManager! {
        didSet {
            castDisplayManager.collectionCast = self.collectionCast
        }
    }

    var detailsFilmPresenter: IDetailsFilmPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        CastViewAssembly.instance().inject(into: self)
        detailsFilmPresenter.setCredits()
    }

}

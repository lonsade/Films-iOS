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
        }
    }

    var castRouting: CastRoutingProtocol!
    var castFilmPresenter: ICastFilmPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        CastViewAssembly.instance().inject(into: self)
        castFilmPresenter.setCredits()
        castRouting.set(viewController: self)
    }

}

//
//  ReviewViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ReviewViewController: BaseViewController {

    @IBOutlet weak var reviewCollection: UICollectionView!

    var reviewDisplayManager: ReviewDisplayManager! {
        didSet {
            reviewDisplayManager.collectionReview = self.reviewCollection
        }
    }

    var presenter: IReviewPresenter!
    var router: ReviewRoutingInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        FilmReviewAssembly.instance().inject(into: self)
        router.viewController = self
        presenter.setReview { [weak self] error in
            if error != nil {
                self?.callAlertError()
            }
        }
    }

}

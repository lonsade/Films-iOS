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

    override func viewDidLoad() {
        super.viewDidLoad()
        ReviewViewAssembly.instance().inject(into: self)
        presenter.setReview()
    }

}

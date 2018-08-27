//
//  ReviewDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class ReviewDisplayManager: NSObject {

    private let reuseIdentifier = "review"

    private var reviewDataSource: IReviewDataSourceOutput

    weak var collectionReview: UICollectionView? {
        didSet {
            collectionReview?.dataSource = self
            collectionReview?.delegate = self
        }
    }

    init(reviewDataSource: IReviewDataSourceOutput) {
        self.reviewDataSource = reviewDataSource
        super.init()
        reviewDataSource.delegate = self
    }

}

extension ReviewDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reviewDataSource.reviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? ReviewCollectionViewCell else { fatalError("Error cell review") }

        cell.setContent(
            name: self.reviewDataSource.reviews[indexPath.item].author,
            content: self.reviewDataSource.reviews[indexPath.item].content
        )

        return cell
    }

}

extension ReviewDisplayManager: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let sizeText = UILabel.size(
            withText: reviewDataSource.reviews[indexPath.item].content,
            forWidth: collectionView.frame.size.width,
            withFont: .FTabName
        )

        let heightImage: CGFloat = 40
        let heightConstraint: CGFloat = 10
        let bottomHeightConstraint: CGFloat = 16

        return CGSize(width: sizeText.width, height: sizeText.height + heightImage + heightConstraint + bottomHeightConstraint + 7)
    }
}

extension ReviewDisplayManager: ReviewDataSourceDelegate {
    func reviewWasAdded(reviews: [Review]) {
        collectionReview?.reloadData()
    }
}

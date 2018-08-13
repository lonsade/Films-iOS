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
            reviewDataSource.delegate = self
            collectionReview?.dataSource = self
            collectionReview?.delegate = self
        }
    }

    init(reviewDataSource: IReviewDataSourceOutput) {
        self.reviewDataSource = reviewDataSource
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
        return CGSize(
            width: reviewDataSource.reviews[indexPath.item].content.getSizeWithFormating(font: UIFont.FTabName).width,
            height: reviewDataSource.reviews[indexPath.item].content.getSizeWithFormating(font: UIFont.FTabName).height + 100
        )
    }
}

extension ReviewDisplayManager: ReviewDataSourceDelegate {
    func reviewWasAdded(reviews: [Review]) {
        collectionReview?.reloadData()
    }
}

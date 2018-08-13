//
//  ReviewPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IReviewPresenter: class {
    func setReview()
}

final class ReviewPresenter: IReviewPresenter {

    private var reviewUsecase: IReviewUsecase
    private var reviewDataSource: IReviewDataSourceInput

    init(
        reviewUsecase: IReviewUsecase,
        reviewDataSource: IReviewDataSourceInput
    ) {
        self.reviewUsecase = reviewUsecase
        self.reviewDataSource = reviewDataSource
    }

    func setReview() {

//        guard let filmId = collectionMoviesRouting.filmId else { fatalError("Film id doesnt exist") }

        let filmId = 550

        reviewUsecase.getReview(relativeURL: "/movie/\(filmId)/reviews").done { reviews in
            self.reviewDataSource.add(reviews: reviews)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

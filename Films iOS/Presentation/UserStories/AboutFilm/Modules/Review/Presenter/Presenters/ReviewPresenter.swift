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
    private var router: ReviewRoutingInput
    private weak var aboutFilmPresenter: AboutFilmInput?

    init(
        reviewUsecase: IReviewUsecase,
        reviewDataSource: IReviewDataSourceInput,
        aboutFilmPresenter: AboutFilmInput,
        router: ReviewRoutingInput
    ) {
        self.reviewUsecase = reviewUsecase
        self.reviewDataSource = reviewDataSource
        self.aboutFilmPresenter = aboutFilmPresenter
        self.router = router
    }

    func setReview() {

        guard let filmId = aboutFilmPresenter?.id else {
            router.closeCurrentModule()
            return assertionFailure("Film id doesnt exist")
        }

        reviewUsecase.getReview(relativeURL: "/movie/\(filmId)/reviews").done { reviews in
            self.reviewDataSource.add(reviews: reviews)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

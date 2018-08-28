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
    var type: Int { get }
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

    var id: Int {
        guard let filmId = aboutFilmPresenter?.id else {
            router.closeCurrentModule()
            assertionFailure("Film id doesnt exist")
            return 0
        }
        return filmId
    }
    var type: Int {
        guard let type = aboutFilmPresenter?.type else {
            router.closeCurrentModule()
            assertionFailure("Type of page doesnt exist")
            return 0
        }
        return type
    }

    func setReview() {

        let url = type == 0 ? "movie" : "tv"

        reviewUsecase.getReview(relativeURL: "/\(url)/\(id)/reviews").done { reviews in
            self.reviewDataSource.add(reviews: reviews)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

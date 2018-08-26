//
//  ReviewPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ReviewPresenterAssembly: Assembly {

    lazy var reviewUsecaseAssembly: ReviewUsecaseAssembly = ReviewUsecaseAssembly.instance()

    lazy var reviewDataSourceAssembly: ReviewDataSourceAssembly = ReviewDataSourceAssembly.instance()

    lazy var presenterAssembly = AboutFilmPresenterAssembly.instance()

    var reviewPresenter: IReviewPresenter {
        return define(init:
            ReviewPresenter(
                reviewUsecase: self.reviewUsecaseAssembly.reviewUsecase,
                reviewDataSource: self.reviewDataSourceAssembly.reviewDataSource,
                aboutFilmPresenter: self.presenterAssembly.aboutFilmPresenter
            )
        )
    }

}

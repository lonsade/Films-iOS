//
//  FilmReviewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class FilmReviewAssembly: Assembly {

    lazy var presenterAssembly = AboutFilmContainerAssembly.instance()

    lazy var usecaseAssembly = AboutFilmAssembly.instance()

    var reviewDataSource: IReviewDataSourceOutput & IReviewDataSourceInput {
        return define(init: ReviewDataSource())
    }

    var reviewDisplayManager: ReviewDisplayManager {
        return define(init: ReviewDisplayManager(reviewDataSource: self.reviewDataSource))
    }

    var reviewPresenter: IReviewPresenter {
        return define(init:
            ReviewPresenter(
                reviewUsecase: self.usecaseAssembly.reviewUsecase,
                reviewDataSource: self.reviewDataSource,
                aboutFilmPresenter: self.presenterAssembly.aboutFilmPresenter
            )
        )
    }

    func inject(into mvc: ReviewViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.reviewPresenter
            $0.reviewDisplayManager = self.reviewDisplayManager
            return $0
        }
    }
}

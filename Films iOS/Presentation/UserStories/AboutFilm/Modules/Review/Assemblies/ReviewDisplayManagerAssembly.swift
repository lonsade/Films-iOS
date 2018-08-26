//
//  ReviewDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ReviewDisplayManagerAssembly: Assembly {

    lazy var reviewDataSourceAssembly = ReviewDataSourceAssembly.instance()

    var reviewDisplayManager: ReviewDisplayManager {
        return define(init:
            ReviewDisplayManager(reviewDataSource: self.reviewDataSourceAssembly.reviewDataSource)
        )
    }

}

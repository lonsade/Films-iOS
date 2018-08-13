//
//  ReviewDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ReviewDataSourceAssembly: Assembly {
    var reviewDataSource: IReviewDataSourceOutput & IReviewDataSourceInput {
        return define(scope: .lazySingleton, init: ReviewDataSource())
    }
}

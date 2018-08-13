//
//  ReviewUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ReviewUsecaseAssembly: Assembly {

    lazy var reviewGatewayAssembly: ReviewGatewayAssembly = self.context.assembly()

    var reviewUsecase: IReviewUsecase {
        return define(scope: .lazySingleton, init:
            ReviewUsecase(makeRequestGatewayCast: self.reviewGatewayAssembly.reviewGateway)
        )
    }

}

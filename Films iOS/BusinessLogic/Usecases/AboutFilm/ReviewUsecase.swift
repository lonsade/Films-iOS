//
//  ReviewUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IReviewUsecase: class {
    func getReview(relativeURL: String) -> Promise<[Review]>
}

final class ReviewUsecase: IReviewUsecase {

    private var makeRequestGatewayCast: IMakeRequestGateway

    init(makeRequestGatewayCast: IMakeRequestGateway) {
        self.makeRequestGatewayCast = makeRequestGatewayCast
    }

    func getReview(relativeURL: String) -> Promise<[Review]> {
        return Promise<[Review]> { seal in
            makeRequestGatewayCast.getResults(relativeURL: relativeURL, parameters: nil).done { (reviews: Reviews) in
                seal.fulfill(reviews.results)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}

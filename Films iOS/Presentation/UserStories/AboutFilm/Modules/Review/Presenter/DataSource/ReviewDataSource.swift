//
//  ReviewDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IReviewDataSourceInput: class {
    func add(reviews: [Review])
}

protocol IReviewDataSourceOutput: class {
    var reviews: [Review] { get }
    var delegate: ReviewDataSourceDelegate? { get set }
}

final class ReviewDataSource: IReviewDataSourceInput, IReviewDataSourceOutput {

    weak var delegate: ReviewDataSourceDelegate?

    func add(reviews: [Review]) {
        self.reviews = reviews
        delegate?.reviewWasAdded(reviews: reviews)
    }

    var reviews: [Review]

    init() {
        reviews = []
    }

}

protocol ReviewDataSourceDelegate: class {
    func reviewWasAdded(reviews: [Review])
}

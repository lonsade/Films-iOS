//
//  ReviewViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class ReviewViewAssembly: Assembly {

    lazy var presenterAssembly = ReviewPresenterAssembly.instance()

    lazy var displayManagerAssembly = ReviewDisplayManagerAssembly.instance()

    func inject(into mvc: ReviewViewController) {
        defineInjection(into: mvc) {
            $0.presenter = self.presenterAssembly.reviewPresenter
            $0.reviewDisplayManager = self.displayManagerAssembly.reviewDisplayManager
            return $0
        }
    }
}

//
//  ReviewRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol ReviewRoutingInput: BaseRoutingProtocol {

}

final class ReviewRouting: ReviewRoutingInput {

    weak var viewController: BaseHandlerController?

    func closeCurrentModule() {
        viewController?.closeModule()
    }
}

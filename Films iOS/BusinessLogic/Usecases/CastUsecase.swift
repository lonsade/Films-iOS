//
//  CastUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol ICastUsecase: class {
    func getCast() -> Promise<[Cast]>
}

final class CastUsecase: ICastUsecase {

    private var makeRequestGatewayCast: IMakeRequestGateway

    init(makeRequestGatewayCast: IMakeRequestGateway) {
        self.makeRequestGatewayCast = makeRequestGatewayCast
    }

    func getCast() -> Promise<[Cast]> {
        return Promise<[Cast]> { seal in
            makeRequestGatewayCast.getResults().done { (credits: Credits) in
                seal.fulfill(credits.cast)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}

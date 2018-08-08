//
//  CastUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class CastUsecaseAssembly: Assembly {

    lazy var requestCastAssembly: MakeRequestGatewayCastAssembly = self.context.assembly()

    var castUsecase: ICastUsecase {
        return define(scope: .lazySingleton, init:
            CastUsecase(makeRequestGatewayCast: self.requestCastAssembly.makeRequestGatewayCast)
        )
    }

}

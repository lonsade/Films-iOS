//
//  CastFilmUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class CastFilmUsecaseAssembly: Assembly {

    lazy var castFilmGatewayAssembly: CastFilmGatewayAssembly = self.context.assembly()

    var castFilmUsecase: ICastUsecase {
        return define(scope: .lazySingleton, init:
            CastUsecase(makeRequestGatewayCast: self.castFilmGatewayAssembly.castFilmGateway)
        )
    }

}

//
//  CastRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class CastRoutingAssembly: Assembly {

    lazy var castDisplayManagerAssembly = CastDisplayManagerAssembly.instance()

    lazy var castFilmDataSourceAssembly = CastFilmDataSourceAssembly.instance()

    var castRouting: CastRoutingProtocol {
        return define(scope: .lazySingleton, init:
            CastRouting(
                castDisplayManager: self.castDisplayManagerAssembly.castDisplayManager,
                castFilmDataSourceOutput: self.castFilmDataSourceAssembly.castFilmDataSource
            )
        )
    }

}

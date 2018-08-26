//
//  CastDisplayAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class CastDisplayManagerAssembly: Assembly {

    lazy var castFilmDataSourceAssembly: CastFilmDataSourceAssembly = CastFilmDataSourceAssembly.instance()

    var castDisplayManager: CastDisplayManager {
        return define(init:
            CastDisplayManager(castDataSource: self.castFilmDataSourceAssembly.castFilmDataSource)
        )
    }

}

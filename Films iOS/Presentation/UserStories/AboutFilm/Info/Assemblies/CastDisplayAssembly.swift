//
//  CastDisplayAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class CastDisplayManagerAssembly: Assembly {

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = self.context.assembly()

    var castDisplayManager: CastDisplayManager {
        return define(scope: .lazySingleton, init:
            CastDisplayManager(castDataSource: self.detailsFilmDataSourceAssembly.detailsFilmDataSource)
        )
    }

}

//
//  CastFilmDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class CastFilmDataSourceAssembly: Assembly {
    var castFilmDataSource: ICastFilmDataSourceOutput & ICastFilmDataSourceInput {
        return define(scope: .lazySingleton, init: CastFilmDataSource())
    }
}

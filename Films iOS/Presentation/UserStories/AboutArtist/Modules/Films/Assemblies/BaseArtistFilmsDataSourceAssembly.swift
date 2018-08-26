//
//  BaseArtistFilmsDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class BaseArtistFilmsDataSourceAssembly: Assembly {
    var baseArtistFilmsDataSource: BaseFilmsDataSourceOutput & BaseFilmsDataSourceInput {
        return define(init: BaseFilmsDataSource())
    }
}

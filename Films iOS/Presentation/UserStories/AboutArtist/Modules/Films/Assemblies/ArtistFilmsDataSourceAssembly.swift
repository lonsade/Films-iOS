//
//  ArtistFilmsDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistFilmsDataSourceAssembly: Assembly {
    var artistFilmsDataSource: BaseMoviesDataSourceOutput & BaseMoviesDataSourceInput {
        return define(scope: .lazySingleton, init: BaseMoviesDataSource())
    }
}
//
//  DetailsFilmDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class DetailsFilmDataSourceAssembly: Assembly {
    var detailsFilmDataSource: IDetailsFilmDataSourceOutput & IDetailsFilmDataSourceInput {
        return define(init: DetailsFilmDataSource())
    }

    var similarFilmDataSource: SimilarFilmsDataSourceOutput & SimilarFilmsDataSourceInput {
        return define(init: SimilarFilmsDataSource())
    }
}

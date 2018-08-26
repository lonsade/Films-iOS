//
//  SearchFilmsDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class SearchFilmsDataSourceAssembly: Assembly {
    var searchFilmsDataSource: SearchFilmsDataSourceInput & SearchFilmsDataSourceOutput {
        return define(init: SearchFilmsDataSource())
    }
}

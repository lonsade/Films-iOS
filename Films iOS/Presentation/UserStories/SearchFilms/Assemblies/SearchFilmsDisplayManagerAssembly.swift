//
//  SearchFilmsDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class SearchFilmsDisplayManagerAssembly: Assembly {

    lazy var dataSourceAssembly = SearchFilmsDataSourceAssembly.instance()

    var searchFilmsDisplayManager: SearchFilmsDisplayManagerOutput {
        return define(init: SearchFilmsDisplayManager(dataSource: self.dataSourceAssembly.searchFilmsDataSource))
    }
}

//
//  BaseFilmsDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class BaseFilmsDataSourceAssembly: Assembly {
    var baseFilmsDataSource: BaseFilmsDataSourceInput & BaseFilmsDataSourceOutput {
        return define(scope: .lazySingleton, init: BaseFilmsDataSource())
    }
}

//
//  TabNamesPresenterAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class TabNamesPresenterAssembly: Assembly {

    lazy var tabNamesUsecaseAssembly: TabNamesUsecaseAssembly = TabNamesUsecaseAssembly.instance()

    lazy var tabNamesDataSourceAssembly: TabNamesDataSourceAssembly = TabNamesDataSourceAssembly.instance()

    var tabNamesPresenter: ITabNamesPresenter {
        return define(scope: .lazySingleton, init:
            TabNamesPresenter(
                tabNamesUsecase: self.tabNamesUsecaseAssembly.tabNamesUsecase,
                dataSource: self.tabNamesDataSourceAssembly.tabNamesDataSourceAssembly
            )
        )
    }

}

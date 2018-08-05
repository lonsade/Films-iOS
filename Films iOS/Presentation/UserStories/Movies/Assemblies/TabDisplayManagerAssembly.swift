//
//  TabDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class TabDisplayManagerAssembly: Assembly {

    lazy var tabNamesDSAssembly: TabNamesDataSourceAssembly = self.context.assembly()

    var tabDisplayManager: TabDisplayManager {
        return define(scope: .lazySingleton, init:
            TabDisplayManager(tabNamesDataSource: self.tabNamesDSAssembly.tabNamesDataSourceAssembly)
        )
    }

}

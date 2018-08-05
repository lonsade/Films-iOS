//
//  TabNamesDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class TabNamesDataSourceAssembly: Assembly {
    var tabNamesDataSourceAssembly: ITabNamesDataSourceOutput & ITabNamesDataSourceInput {
        return define(scope: .lazySingleton, init: TabNamesDataSource())
    }

}

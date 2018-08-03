//
//  TabNamesUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class TabNamesUsecaseAssembly: Assembly {

    lazy var tabNamesGatewayAssembly: TabNamesGatewayAssembly = self.context.assembly()

    var tabNamesUsecase: ITabNamesUsecase {
        return define(scope: .lazySingleton, init:
            TabNamesUsecase(tabNamesGateway: self.tabNamesGatewayAssembly.tabNamesGateway)
        )
    }
}

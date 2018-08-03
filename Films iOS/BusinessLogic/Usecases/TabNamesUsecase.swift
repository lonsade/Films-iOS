//
//  TabNamesUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol ITabNamesUsecase: class {
    func getTabNames() -> Promise<[TabName]>
}

final class TabNamesUsecase: ITabNamesUsecase {

    private var tabNamesGateway: ITabNamesGateway

    init(tabNamesGateway: ITabNamesGateway) {
        self.tabNamesGateway = tabNamesGateway
    }

    func getTabNames() -> Promise<[TabName]> {
        return tabNamesGateway.getTabNames()
    }
}

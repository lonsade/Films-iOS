//
//  ListPopularFilmsUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class ListPopularFilmsUsecaseAssembly: Assembly {

    lazy var listPopularFilmsGatewayAssembly: ListPopularFilmsGatewayAssembly = self.context.assembly()

    var listPopularFilmsUsecase: IListPopularFilmsUsecase {
        return define(scope: .lazySingleton, init:
            ListPopularFilmsUsecase(
                makeRequestGatewayListPopular: self.listPopularFilmsGatewayAssembly.listPopularFilmsGateway
            )
        )
    }
}

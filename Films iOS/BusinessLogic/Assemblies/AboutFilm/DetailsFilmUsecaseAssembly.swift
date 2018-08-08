//
//  DetailsFilmUsecaseAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class DetailsFilmUsecaseAssembly: Assembly {

    lazy var requestFilmDetailAssembly: MakeRequestGatewayFilmDetailsAssembly = self.context.assembly()

    var detailsFilmUsecase: IDetailsFilmUsecase {
        return define(scope: .lazySingleton, init:
            DetailsFilmUsecase(
                makeRequestGatewayFilmDetail: self.requestFilmDetailAssembly.makeRequestGatewayFilmDetails
            )
        )
    }
}

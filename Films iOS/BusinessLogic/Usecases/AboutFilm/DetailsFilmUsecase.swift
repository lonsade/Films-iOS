//
//  DetailsFilmUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IDetailsFilmUsecase: class {
    func getFilmDetails(relativeURL: String) -> Promise<FilmDetail>
}

final class DetailsFilmUsecase: IDetailsFilmUsecase {

    private var makeRequestGatewayFilmDetail: IMakeRequestGateway

    init(makeRequestGatewayFilmDetail: IMakeRequestGateway) {
        self.makeRequestGatewayFilmDetail = makeRequestGatewayFilmDetail
    }

    func getFilmDetails(relativeURL: String) -> Promise<FilmDetail> {
        return makeRequestGatewayFilmDetail.getResults(relativeURL: relativeURL, parameters: nil)
    }
}

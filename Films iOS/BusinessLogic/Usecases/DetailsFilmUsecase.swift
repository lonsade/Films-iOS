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
    func getFilmDetails() -> Promise<FilmDetail>
}

final class DetailsFilmUsecase: IDetailsFilmUsecase {
    private var detailsFilmGateway: IDetailsFilmGateway

    init(detailsFilmGateway: IDetailsFilmGateway) {
        self.detailsFilmGateway = detailsFilmGateway
    }

    func getFilmDetails() -> Promise<FilmDetail> {
        return detailsFilmGateway.getFilmDetails()
    }
}

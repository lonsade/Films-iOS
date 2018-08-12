//
//  ListPopularFilmsUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IListPopularFilmsUsecase: class {
    func getPopularFilms(relativeURL: String) -> Promise<[FilmCard]>
}

final class ListPopularFilmsUsecase: IListPopularFilmsUsecase {

    private var makeRequestGatewayListPopular: IMakeRequestGateway

    init(makeRequestGatewayListPopular: IMakeRequestGateway) {
        self.makeRequestGatewayListPopular = makeRequestGatewayListPopular
    }

    func getPopularFilms(relativeURL: String) -> Promise<[FilmCard]> {
        return Promise<[FilmCard]> { seal in
            makeRequestGatewayListPopular.getResults(relativeURL: relativeURL).done { (films: Films) in
                seal.fulfill(films.results)
            }.catch { error in
                seal.reject(error)
            }
        }

    }
}

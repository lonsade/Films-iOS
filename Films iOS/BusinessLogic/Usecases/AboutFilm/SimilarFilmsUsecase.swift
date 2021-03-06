//
//  SimilarFilmsUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol ISimilarFilmsUsecase: class {
    func getSimilar(relativeURL: String) -> Promise<[FilmCard]>
}

final class SimilarFilmsUsecase: ISimilarFilmsUsecase {
    private var makeRequestGatewaySimilar: IMakeRequestGateway

    private var page = 0

    init(makeRequestGatewaySimilar: IMakeRequestGateway) {
        self.makeRequestGatewaySimilar = makeRequestGatewaySimilar
    }

    func getSimilar(relativeURL: String) -> Promise<[FilmCard]> {
        page += 1
        return Promise<[FilmCard]> { seal in
            makeRequestGatewaySimilar.getResults(relativeURL: relativeURL, parameters: ["page": page]).done { (films: Films) in
                seal.fulfill(films.results)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
}

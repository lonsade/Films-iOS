//
//  SearchFilmsUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import PromiseKit

protocol SearchFilmsUsecaseOutput: class {
    func getSearchFilms(relativeURL: String, query: String) -> Promise<[FilmCard]>
}

final class SearchFilmsUsecase: SearchFilmsUsecaseOutput {

    private var makeRequestGatewaySearch: IMakeRequestGateway
    private var page = 0

    init(makeRequestGatewaySearch: IMakeRequestGateway) {
        self.makeRequestGatewaySearch = makeRequestGatewaySearch
    }

    func getSearchFilms(relativeURL: String, query: String) -> Promise<[FilmCard]> {
        page += 1
        return Promise<[FilmCard]> { seal in
            makeRequestGatewaySearch.getResults(relativeURL: relativeURL, parameters: ["page": page, "query": query])
            .done { (films: Films) in
                seal.fulfill(films.results)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
}

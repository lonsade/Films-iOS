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
    func getPopularFilms(relativeURL: String, parameters: [String: Any]?, genreId: Int, type: Int) -> Promise<[CategoryFilm]>
}

final class ListPopularFilmsUsecase: IListPopularFilmsUsecase {

    private var makeRequestGatewayListPopular: IMakeRequestGateway
    private var filmsAccessor: RealmAccessor<CategoryFilm>

    init(makeRequestGatewayListPopular: IMakeRequestGateway, filmsAccessor: RealmAccessor<CategoryFilm>) {
        self.makeRequestGatewayListPopular = makeRequestGatewayListPopular
        self.filmsAccessor = filmsAccessor
    }

    private var page = 0

    private func filmCardsToCategoryFilms(cardFilms: [FilmCard], type: Int, genreId: Int) -> [CategoryFilm] {
        var categoryFilms: [CategoryFilm] = []
        cardFilms.forEach {
            categoryFilms.append(CategoryFilm(
                genreId: genreId,
                type: type,
                posterPath: $0.posterPath,
                overview: $0.overview,
                id: $0.id,
                title: $0.title,
                voteAverage: $0.voteAverage,
                adult: $0.adult,
                name: $0.name)
            )
        }
        return categoryFilms
    }

    func getPopularFilms(relativeURL: String, parameters: [String: Any]?, genreId: Int, type: Int) -> Promise<[CategoryFilm]> {
        page += 1
        var newParameters = parameters
        if newParameters != nil {
            newParameters!["page"] = page
        }
        return Promise<[CategoryFilm]> { seal in
            makeRequestGatewayListPopular.getResults(relativeURL: relativeURL, parameters: newParameters).done { (films: Films) in

                // при следующей подгрузки фильмов они берутся онли из сервера
                if self.page > 0 {
                    seal.fulfill(self.filmCardsToCategoryFilms(cardFilms: films.results, type: type, genreId: genreId))
                }

                self.filmsAccessor.add(objects: self.filmCardsToCategoryFilms(cardFilms: films.results, type: type, genreId: genreId))

                let movies: [CategoryFilm] = self.filmsAccessor.get(usingQuery: "genreId == \(genreId) AND type == \(type)").map {
                    $0.toPlainObject()
                }
                seal.fulfill(movies)
            }.catch { error in
                if let networkError = error as? NetworkingError, networkError == NetworkingError.networkingError {
                    let movies: [CategoryFilm] = self.filmsAccessor.get(usingQuery: "genreId == \(genreId) AND type == \(type)").map {
                        $0.toPlainObject()
                    }
                    if movies.isEmpty {
                        seal.reject(error)
                    }
                    seal.fulfill(movies)
                }
                seal.reject(error)
            }
        }

    }
}

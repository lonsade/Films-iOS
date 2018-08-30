//
//  PopularFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IPopularFilmsPresenter: ModuleInput {
    func setFilms(completion: @escaping Response)
    var type: Int! { get }
}

protocol FilmsPresenterInput: ModuleInput {
    var dataSource: BaseMoviesDataSourceInput { get }
    func set(genre: TabName, type: Int)
}

final class PopularFilmsPresenter: IPopularFilmsPresenter, FilmsPresenterInput {

    func set(genre: TabName, type: Int) {
        self.genre = genre
        self.type = type
    }

    var type: Int!

    private var genre: TabName!

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    internal var dataSource: BaseMoviesDataSourceInput

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSourceInput) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func setFilms(completion: @escaping Response) {

        var relativeURL: String = (type == 0) ? "/discover/movie" : "/discover/tv"

        var parameters: [String: Any] = [:]

        if genre.id > -1 {
            parameters["with_genres"] = String(genre.id)
        } else if genre.id == -2 {
            relativeURL = (type == 0) ? "/movie/now_playing" : "/tv/on_the_air"
        }

        listPopularFilmsUsecase.getPopularFilms(
            relativeURL: relativeURL,
            parameters: parameters,
            genreId: genre.id,
            type: type
        ).done { films in

            // TODO: можно в принципе убрать делегат в датасоурс и передавать в comp

            self.dataSource.load(films: films)
            completion(nil)
        }
        .catch { error in
            completion(error)
        }
    }

}

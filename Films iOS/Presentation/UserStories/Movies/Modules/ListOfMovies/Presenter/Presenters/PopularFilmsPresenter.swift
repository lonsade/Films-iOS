//
//  PopularFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IPopularFilmsPresenter: ModuleInput {
    func setFilms()
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

    private var type: Int!

    private var genre: TabName!

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    internal var dataSource: BaseMoviesDataSourceInput

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSourceInput) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    private var page = 0

    func setFilms() {
        page += 1

        var parameters: [String: Any] = ["page": page]
        var relativeURL: String = (type == 0) ? "/discover/movie" : "/discover/tv"

        if genre.id > -1 {
            parameters["with_genres"] = String(genre.id)
        } else if genre.id == -2 {
            relativeURL = "/movie/now_playing"
        }

        listPopularFilmsUsecase.getPopularFilms(
            relativeURL: relativeURL,
            parameters: parameters
        ).done { films in
            self.dataSource.load(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

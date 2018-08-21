//
//  FilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IFilmsPresenter: class {
    func loadPopularFilms()
}

final class FilmsPresenter: IFilmsPresenter {

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    private var dataSource: BaseMoviesDataSource

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSource) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func loadPopularFilms() {

        listPopularFilmsUsecase.getPopularFilms(relativeURL: "/movie/popular").done { films in
            self.dataSource.load(base: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

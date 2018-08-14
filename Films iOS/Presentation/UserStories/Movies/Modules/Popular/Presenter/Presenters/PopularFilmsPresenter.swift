//
//  PopularFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IPopularFilmsPresenter: class {
    func setPopularFilms()
}

protocol FilmsPresenterInput {
    var dataSource: BaseMoviesDataSource { get }
}

final class PopularFilmsPresenter: IPopularFilmsPresenter, FilmsPresenterInput {

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    internal var dataSource: BaseMoviesDataSource

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSource) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func setPopularFilms() {
        listPopularFilmsUsecase.getPopularFilms(relativeURL: "/movie/popular").done { films in
            self.dataSource.add(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

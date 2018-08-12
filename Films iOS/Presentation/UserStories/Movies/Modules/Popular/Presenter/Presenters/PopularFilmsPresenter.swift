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

final class PopularFilmsPresenter: IPopularFilmsPresenter {

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    private var dataSource: BaseMoviesDataSourceInput

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSourceInput) {
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
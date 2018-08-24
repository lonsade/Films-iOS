//
//  FilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IFilmsPresenter: class {
    func loadPopularFilms(firstly: Bool)
}

final class FilmsPresenter: IFilmsPresenter {

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    private var dataSource: BaseFilmsDataSourceInput

    init(
        listPopularFilmsUsecase: IListPopularFilmsUsecase,
        dataSource: BaseFilmsDataSourceInput
    ) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func loadPopularFilms(firstly: Bool) {

        listPopularFilmsUsecase.getPopularFilms(relativeURL: "/movie/popular").done { films in
            self.dataSource.load(base: films, firstly: firstly)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

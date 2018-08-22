//
//  PopularFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IPopularFilmsPresenter: ModuleInput {
    func setPopularFilms()
}

protocol FilmsPresenterInput: ModuleInput {
    var dataSource: BaseMoviesDataSource { get }
    func setAndUpdate(genre: TabName)
    func set(genre: TabName)
}

final class PopularFilmsPresenter: IPopularFilmsPresenter, FilmsPresenterInput {

    func setAndUpdate(genre: TabName) {
        self.genre = genre
        setPopularFilms()
    }
    func set(genre: TabName) {
        self.genre = genre
    }

    private var genre: TabName!

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    internal var dataSource: BaseMoviesDataSource

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: BaseMoviesDataSource) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func setPopularFilms() {
        self.dataSource.filter(genre: self.genre)
    }

}

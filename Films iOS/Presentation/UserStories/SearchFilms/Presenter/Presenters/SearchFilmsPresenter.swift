//
//  SearchFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol SearchFilmsPresenterOutput: class {

}

protocol SearchFilmsPresenterInput: class {
    func setSearchFilms(onText text: String)
    func loadMore()
    func clear()
}

final class SearchFilmsPresenter: SearchFilmsPresenterOutput, SearchFilmsPresenterInput {

    private var dataSource: SearchFilmsDataSourceInput
    private var usecase: SearchFilmsUsecaseOutput
    private var query: String!

    init(dataSource: SearchFilmsDataSourceInput, usecase: SearchFilmsUsecaseOutput) {
        self.dataSource = dataSource
        self.usecase = usecase
    }

    func setSearchFilms(onText text: String) {
        query = text
        usecase.page = 0
        usecase.getSearchFilms(relativeURL: "/search/movie", query: query).done { films in
            self.dataSource.set(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func clear() {
        dataSource.clear()
        usecase.page = 0
    }

    func loadMore() {
        usecase.getSearchFilms(relativeURL: "/search/movie", query: query).done { films in
            self.dataSource.add(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

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
}

final class SearchFilmsPresenter: SearchFilmsPresenterOutput, SearchFilmsPresenterInput {

    private var dataSource: SearchFilmsDataSourceInput
    private var usecase: SearchFilmsUsecaseOutput

    init(dataSource: SearchFilmsDataSourceInput, usecase: SearchFilmsUsecaseOutput) {
        self.dataSource = dataSource
        self.usecase = usecase
    }

    func setSearchFilms(onText text: String) {
        usecase.getSearchFilms(relativeURL: "/search/movie", query: text).done { films in
            self.dataSource.add(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

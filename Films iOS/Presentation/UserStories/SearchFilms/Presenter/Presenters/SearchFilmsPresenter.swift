//
//  SearchFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol SearchFilmsPresenterOutput: ModuleInput {

}

protocol SearchFilmsPresenterInput: ModuleInput {
    func setSearchFilms(onText text: String, completion: @escaping Response)
    func loadMore(completion: @escaping Response)
    func clear()
    func set(type: Int)
    var type: Int! { get }
}

final class SearchFilmsPresenter: SearchFilmsPresenterOutput, SearchFilmsPresenterInput {

    private var dataSource: SearchFilmsDataSourceInput
    private var usecase: SearchFilmsUsecaseOutput
    private var query: String!
    var type: Int!

    func set(type: Int) {
        self.type = type
    }

    init(dataSource: SearchFilmsDataSourceInput, usecase: SearchFilmsUsecaseOutput) {
        self.dataSource = dataSource
        self.usecase = usecase
    }

    func setSearchFilms(onText text: String, completion: @escaping Response) {
        query = text
        usecase.page = 0
        let url = type == 0 ? "movie" : "tv"
        usecase.getSearchFilms(relativeURL: "/search/\(url)", query: query).done { films in
            self.dataSource.set(films: films)
            completion(nil)
        }
        .catch { error in
            completion(error)
        }
    }

    func clear() {
        dataSource.clear()
        usecase.page = 0
    }

    func loadMore(completion: @escaping Response) {
        let url = type == 0 ? "movie" : "tv"
        usecase.getSearchFilms(relativeURL: "/search/\(url)", query: query).done { films in
            self.dataSource.add(films: films)
            completion(nil)
        }
        .catch { error in
            completion(error)
        }
    }
}

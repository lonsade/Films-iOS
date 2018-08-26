//
//  SearchFilmsDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol SearchFilmsDataSourceInput: class {
    func add(films: [FilmCard])
}

protocol SearchFilmsDataSourceOutput: class {
    var dataSource: [FilmCard] { get }
    var delegate: SearchFilmsDataSourceDelegate? { get set }
}

protocol SearchFilmsDataSourceDelegate: class {
    func filmsWereAdd()
}

final class SearchFilmsDataSource: SearchFilmsDataSourceOutput, SearchFilmsDataSourceInput {
    var dataSource: [FilmCard]

    weak var delegate: SearchFilmsDataSourceDelegate?

    func add(films: [FilmCard]) {
        dataSource += films
        delegate?.filmsWereAdd()
    }

    init() {
        dataSource = []
    }
}

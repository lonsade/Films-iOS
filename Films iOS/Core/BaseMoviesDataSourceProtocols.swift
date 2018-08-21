//
//  BaseMoviesDataSourceProtocols.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol BaseMoviesDataSourceInput: class {
    func filter(genre: TabName?)
    func load(base: [FilmCard])
}

protocol BaseMoviesDataSourceOutput: class {
    var base: [FilmCard] { get }
    var films: [FilmCard] { get }
    var delegate: BaseMoviesDataSourceDelegate? { get set }
}

protocol BaseMoviesDataSourceDelegate: class {
    func moviesWereAdd()
}

final class BaseMoviesDataSource: BaseMoviesDataSourceInput, BaseMoviesDataSourceOutput {

    var base: [FilmCard]

    weak var delegate: BaseMoviesDataSourceDelegate?

    func load(base: [FilmCard]) {
        self.base = base
        self.films = base
        delegate?.moviesWereAdd()
    }

    func filter(genre: TabName?) {

        if let genre = genre {
            self.films = base.filter {
                return $0.genreIds.contains(genre.id)
            }
        } else {
            self.films = base
        }
        delegate?.moviesWereAdd()
    }

    var films: [FilmCard]

    init() {
        films = []
        base = []
    }
}

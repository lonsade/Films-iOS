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
    func load(films: [FilmCard])
}

protocol BaseMoviesDataSourceOutput: class {
    var films: [FilmCard] { get }
    var delegate: BaseMoviesDataSourceDelegate? { get set }
    var loadDelegate: BaseMoviesDataSourceLoadDelegate? { get set }
}

protocol BaseMoviesDataSourceDelegate: class {
    func moviesWereAdd()
}

protocol BaseMoviesDataSourceLoadDelegate: class {
    func notEnoughMovies()
}

final class BaseMoviesDataSource: BaseMoviesDataSourceInput, BaseMoviesDataSourceOutput {

    // store base of films
    private var baseFilmsDataSource: BaseFilmsDataSourceOutput!

    weak var delegate: BaseMoviesDataSourceDelegate?

    weak var loadDelegate: BaseMoviesDataSourceLoadDelegate?

    weak var filmsDelegate: BaseFilmsDataSourceDelegate?

    private var countVisibleFilms = 20

    func filter(genre: TabName?) {

        guard let genre = genre else { return }

        if genre.id != -1 {
            self.films = baseFilmsDataSource.base.filter {
                return $0.genreIds.contains(genre.id)
            }
        } else {
            self.films = baseFilmsDataSource.base
        }

        if countVisibleFilms <= self.films.count {
            self.films = Array(self.films[0..<countVisibleFilms])
            countVisibleFilms += 10
            delegate?.moviesWereAdd()
        } else {
            loadDelegate?.notEnoughMovies()
        }

    }

    func load(films: [FilmCard]) {
        self.films += films
        delegate?.moviesWereAdd()
    }

    var films: [FilmCard]

    init(baseFilmsDataSource: BaseFilmsDataSourceOutput) {
        self.baseFilmsDataSource = baseFilmsDataSource
        films = []
    }
}

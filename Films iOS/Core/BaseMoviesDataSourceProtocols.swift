//
//  BaseMoviesDataSourceProtocols.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol BaseMoviesDataSourceInput: class {
    func add(films: [FilmCard])
}

protocol BaseMoviesDataSourceOutput: class {
    var films: [FilmCard] { get }
    var delegate: BaseMoviesDataSourceDelegate? { get set }
}

protocol BaseMoviesDataSourceDelegate: class {
    func moviesWereAdd()
}

final class BaseMoviesDataSource: BaseMoviesDataSourceInput, BaseMoviesDataSourceOutput {

    weak var delegate: BaseMoviesDataSourceDelegate?

    func add(films: [FilmCard]) {
        self.films = films
        delegate?.moviesWereAdd()
    }

    var films: [FilmCard]

    init() {
        films = []
    }
}

//
//  ListPopularDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IListPopularDataSourceInput: class {
    func addFilms(films: [FilmCard])
}

protocol IListPopularDataSourceOutput: class {
    var films: [FilmCard] { get }
    var delegate: FilmsDSDelegate? { get set }
}

final class ListPopularDataSource: IListPopularDataSourceInput, IListPopularDataSourceOutput {
    var films: [FilmCard]

    weak var delegate: FilmsDSDelegate?

    func addFilms(films: [FilmCard]) {
        self.films = films
        delegate?.filmsWasAdded(films: films)
    }

    init() {
        films = []
    }
}

protocol FilmsDSDelegate: class {
    func filmsWasAdded(films: [FilmCard])
}

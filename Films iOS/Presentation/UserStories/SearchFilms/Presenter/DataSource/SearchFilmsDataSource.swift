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
    func set(films: [FilmCard])
    func clear()
}

protocol SearchFilmsDataSourceOutput: class {
    var data: [FilmCard] { get }
    var delegate: SearchFilmsDataSourceDelegate? { get set }
}

protocol SearchFilmsDataSourceDelegate: class {
    func filmsWereAdd(withIndexPaths indexPaths: [IndexPath])
}

final class SearchFilmsDataSource: SearchFilmsDataSourceOutput, SearchFilmsDataSourceInput {
    var data: [FilmCard]

    weak var delegate: SearchFilmsDataSourceDelegate?

    func add(films: [FilmCard]) {
        if !films.isEmpty {
            let fristIndex = self.data.count
            data += films
            var indexPaths: [IndexPath] = []
            for item in fristIndex..<self.data.count {
                indexPaths.append(IndexPath(item: item, section: 0))
            }
            delegate?.filmsWereAdd(withIndexPaths: indexPaths)
        }
    }

    func set(films: [FilmCard]) {
        if !films.isEmpty {
            let fristIndex = self.data.count
            data = films
            var indexPaths: [IndexPath] = []
            for item in fristIndex..<self.data.count {
                indexPaths.append(IndexPath(item: item, section: 0))
            }
            delegate?.filmsWereAdd(withIndexPaths: indexPaths)
        }
    }

    func clear() {
        data = []
        delegate?.filmsWereAdd(withIndexPaths: [])
    }

    init() {
        data = []
    }
}

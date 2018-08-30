//
//  BaseMoviesDataSourceProtocols.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol BaseMoviesDataSourceInput: class {
    func load(films: [CategoryFilm])
}

protocol BaseMoviesDataSourceOutput: class {
    var films: [CategoryFilm] { get }
    var delegate: BaseMoviesDataSourceDelegate? { get set }
}

protocol BaseMoviesDataSourceDelegate: class {
    func moviesWereAdd(withIndexPaths indexPaths: [IndexPath])
}

final class BaseMoviesDataSource: BaseMoviesDataSourceInput, BaseMoviesDataSourceOutput {

    weak var delegate: BaseMoviesDataSourceDelegate?

    func load(films: [CategoryFilm]) {
        let firstIndex = self.films.count
        self.films += films
        var indexPaths: [IndexPath] = []
        for item in firstIndex..<self.films.count {
            indexPaths.append(IndexPath(item: item, section: 0))
        }
        delegate?.moviesWereAdd(withIndexPaths: indexPaths)
    }

    var films: [CategoryFilm]

    init() {
        films = []
    }
}

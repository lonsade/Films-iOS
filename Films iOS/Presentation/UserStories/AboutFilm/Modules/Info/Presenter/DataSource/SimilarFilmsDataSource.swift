//
//  SimilarFilmsDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol SimilarFilmsDataSourceInput: class {
    func load(base: [FilmCard])
}

protocol SimilarFilmsDataSourceOutput: class {
    var base: [FilmCard] { get }
    var delegate: SimilarFilmsDataSourceDelegate? { get set }
}

protocol SimilarFilmsDataSourceDelegate: class {
    func baseWasAdd()
}

final class SimilarFilmsDataSource: SimilarFilmsDataSourceInput, SimilarFilmsDataSourceOutput {

    var base: [FilmCard]

    weak var delegate: SimilarFilmsDataSourceDelegate?

    func load(base: [FilmCard]) {
        self.base += base
        delegate?.baseWasAdd()
    }

    init() {
        base = []
    }
}

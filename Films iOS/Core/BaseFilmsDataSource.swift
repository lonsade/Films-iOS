//
//  BaseFilmsDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 21.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol BaseFilmsDataSourceInput: class {
    func load(base: [FilmCard], firstly: Bool)
}

protocol BaseFilmsDataSourceOutput: class {
    var base: [FilmCard] { get }
    var delegate: BaseFilmsDataSourceDelegate? { get set }
}

protocol BaseFilmsDataSourceDelegate: class {
    func baseWasAdd()
}

final class BaseFilmsDataSource: BaseFilmsDataSourceInput, BaseFilmsDataSourceOutput {

    var base: [FilmCard]

    weak var delegate: BaseFilmsDataSourceDelegate?

    func load(base: [FilmCard], firstly: Bool) {
        if firstly {
            self.base = base
        } else {
            self.base += base
        }
        delegate?.baseWasAdd()
    }

    static let addedFilmsKey = "addedFilms"

    init() {
        base = []
    }
}

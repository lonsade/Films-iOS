//
//  ArtistFilmsDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ArtistFilmsDataSourceInput: class {
    func load(base: [FilmCard])
}

protocol ArtistFilmsDataSourceOutput: class {
    var base: [FilmCard] { get }
    var delegate: ArtistFilmsDataSourceDelegate? { get set }
}

protocol ArtistFilmsDataSourceDelegate: class {
    func baseWasAdd()
}

final class ArtistFilmsDataSource: ArtistFilmsDataSourceInput, ArtistFilmsDataSourceOutput {

    var base: [FilmCard]

    weak var delegate: ArtistFilmsDataSourceDelegate?

    func load(base: [FilmCard]) {
        self.base += base
        delegate?.baseWasAdd()
    }

    init() {
        base = []
    }
}

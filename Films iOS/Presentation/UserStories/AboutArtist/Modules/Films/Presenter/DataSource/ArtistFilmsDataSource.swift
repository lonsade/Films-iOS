//
//  ArtistFilmsDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IArtistFilmsDataSourceInput: class {
    func add(artistFilms: [FilmCard])
}

protocol IArtistFilmsDataSourceOutput: class {
    var artistFilms: [FilmCard] { get }
    var delegate: ArtistFilmsDataSourceDelegate? { get set }
}

final class ArtistFilmsDataSource: IArtistFilmsDataSourceInput, IArtistFilmsDataSourceOutput {

    weak var delegate: ArtistFilmsDataSourceDelegate?

    func add(artistFilms: [FilmCard]) {
        self.artistFilms = artistFilms
        delegate?.artistFilmsWereAdd()
    }

    var artistFilms: [FilmCard]

    init() {
        artistFilms = []
    }

}

protocol ArtistFilmsDataSourceDelegate: class {
    func artistFilmsWereAdd()
}

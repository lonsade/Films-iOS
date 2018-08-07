//
//  DetailsFilmDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IDetailsFilmDataSourceInput: class {
    func addDetails(details: FilmDetail)
}

protocol IDetailsFilmDataSourceOutput: class {
    var details: FilmDetail? { get }
    var delegate: DetailsFilmDataSourceDelegate? { get set }
}

final class DetailsFilmDataSource: IDetailsFilmDataSourceInput, IDetailsFilmDataSourceOutput {
    weak var delegate: DetailsFilmDataSourceDelegate?

    func addDetails(details: FilmDetail) {
        self.details = details
        delegate?.detailsWasAdded(details: details)
    }

    var details: FilmDetail?

    init() {}

}

protocol DetailsFilmDataSourceDelegate: class {
    func detailsWasAdded(details: FilmDetail)
}

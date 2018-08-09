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
    func addImages(images: [GalleryImage])
}

protocol IDetailsFilmDataSourceOutput: class {
    var details: FilmDetail? { get }
    var images: [GalleryImage] { get }
    var delegate: DetailsFilmDataSourceDelegate? { get set }
}

final class DetailsFilmDataSource: IDetailsFilmDataSourceInput, IDetailsFilmDataSourceOutput {

    weak var delegate: DetailsFilmDataSourceDelegate?

    func addDetails(details: FilmDetail) {
        self.details = details
        delegate?.detailsWasAdded(details: details)
    }

    func addImages(images: [GalleryImage]) {
        self.images = images
        delegate?.imagesWasAdded(images: images)
    }

    var details: FilmDetail?
    var images: [GalleryImage]

    init() {
        images = []
    }

}

protocol DetailsFilmDataSourceDelegate: class {
    func detailsWasAdded(details: FilmDetail)
    func imagesWasAdded(images: [GalleryImage])
}

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
    func addCredits(credits: [Cast])
}

protocol IDetailsFilmDataSourceOutput: class {
    var details: FilmDetail? { get }
    var images: [GalleryImage] { get }
    var credits: [Cast] { get }
    var infoDelegate: DetailsFilmDataSourceInfoDelegate? { get set }
    var castDelegate: DetailsFilmDataSourceCastDelegate? { get set }
    //var infoDelegate: DetailsFilmDataSourceDelegate? { get set }
}

final class DetailsFilmDataSource: IDetailsFilmDataSourceInput, IDetailsFilmDataSourceOutput {

    weak var infoDelegate: DetailsFilmDataSourceInfoDelegate?
    weak var castDelegate: DetailsFilmDataSourceCastDelegate?

    func addDetails(details: FilmDetail) {
        self.details = details
        infoDelegate?.detailsWasAdded(details: details)
    }

    func addImages(images: [GalleryImage]) {
        self.images = images
        infoDelegate?.imagesWasAdded(images: images)
    }

    func addCredits(credits: [Cast]) {
        self.credits = credits
        castDelegate?.creditsWasAdded(credits: credits)
    }

    var details: FilmDetail?
    var images: [GalleryImage]
    var credits: [Cast]

    init() {
        images = []
        credits = []
    }

}

protocol DetailsFilmDataSourceInfoDelegate: class {
    func detailsWasAdded(details: FilmDetail)
    func imagesWasAdded(images: [GalleryImage])
}

protocol DetailsFilmDataSourceCastDelegate: class {
    func creditsWasAdded(credits: [Cast])
}

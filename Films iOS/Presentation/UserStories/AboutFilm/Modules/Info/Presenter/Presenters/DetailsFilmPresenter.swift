//
//  DetailsFilmPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IDetailsFilmPresenter: class {
    func setDetailsFilm()
    func setGallery()
    func setSimilar()
}

final class DetailsFilmPresenter: IDetailsFilmPresenter {

    private var detailsFilmUsecase: IDetailsFilmUsecase
    private var dataSource: IDetailsFilmDataSourceInput
    private var galleryUsecase: IGalleryUsecase
    private var moviesRouting: MoviesRoutingOutput
    private var similarUsecase: ISimilarFilmsUsecase

    init(
        detailsFilmUsecase: IDetailsFilmUsecase,
        dataSource: IDetailsFilmDataSourceInput,
        galleryUsecase: IGalleryUsecase,
        moviesRouting: MoviesRoutingOutput,
        similarUsecase: ISimilarFilmsUsecase
    ) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSource = dataSource
        self.galleryUsecase = galleryUsecase
        self.moviesRouting = moviesRouting
        self.similarUsecase = similarUsecase
    }

    func setDetailsFilm() {

        guard let filmId = moviesRouting.selectFilmId else { fatalError("Film id doesnt exist") }

        detailsFilmUsecase.getFilmDetails(relativeURL: "/movie/\(filmId)").done { details in
            self.dataSource.addDetails(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {

        guard let filmId = moviesRouting.selectFilmId else { fatalError("Film id doesnt exist") }

        galleryUsecase.getGallery(relativeURL: "/movie/\(filmId))/images").done { images in
            self.dataSource.addImages(images: images)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setSimilar() {
        guard let filmId = moviesRouting.selectFilmId else { fatalError("Film id doesnt exist") }

        similarUsecase.getSimilar(relativeURL: "/movie/\(filmId))/similar").done { films in
            self.dataSource.addSimilar(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

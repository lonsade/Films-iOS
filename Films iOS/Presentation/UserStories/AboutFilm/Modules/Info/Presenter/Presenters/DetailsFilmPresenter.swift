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
    private var dataSourceForDetails: IDetailsFilmDataSourceInput
    private var dataSourceForSimilar: BaseMoviesDataSourceInput
    private var galleryUsecase: IGalleryUsecase
    private var moviesRouting: BaseMoviesRoutingOutput
    private var similarUsecase: ISimilarFilmsUsecase

    private var filmId: Int?

    init(
        detailsFilmUsecase: IDetailsFilmUsecase,
        dataSourceForDetails: IDetailsFilmDataSourceInput,
        galleryUsecase: IGalleryUsecase,
        moviesRouting: BaseMoviesRoutingOutput,
        similarUsecase: ISimilarFilmsUsecase,
        dataSourceForSimilar: BaseMoviesDataSourceInput
    ) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSourceForDetails = dataSourceForDetails
        self.galleryUsecase = galleryUsecase
        self.moviesRouting = moviesRouting
        self.similarUsecase = similarUsecase
        self.dataSourceForSimilar = dataSourceForSimilar

    }

    func setDetailsFilm() {

        guard let filmId = moviesRouting.filmId else { fatalError("Film id doesnt exist") }

        detailsFilmUsecase.getFilmDetails(relativeURL: "/movie/\(filmId)").done { details in
            self.dataSourceForDetails.add(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {

        guard let filmId = moviesRouting.filmId else { fatalError("Film id doesnt exist") }

        galleryUsecase.getGallery(relativeURL: "/movie/\(filmId))/images").done { images in
            self.dataSourceForDetails.add(images: images)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setSimilar() {
        guard let filmId = moviesRouting.filmId else { fatalError("Film id doesnt exist") }

        similarUsecase.getSimilar(relativeURL: "/movie/\(filmId))/similar").done { films in
            self.dataSourceForSimilar.add(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

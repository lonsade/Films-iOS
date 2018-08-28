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
    var type: Int { get }
}

final class DetailsFilmPresenter: IDetailsFilmPresenter {

    private var detailsFilmUsecase: IDetailsFilmUsecase
    private var dataSourceForDetails: IDetailsFilmDataSourceInput
    private var dataSourceForSimilar: SimilarFilmsDataSourceInput
    private var galleryUsecase: IGalleryUsecase
    private var similarUsecase: ISimilarFilmsUsecase
    private var router: InfoRoutingInput
    private weak var aboutFilmPresenter: AboutFilmInput?

    var id: Int {
        guard let filmId = aboutFilmPresenter?.id else {
            router.closeCurrentModule()
            assertionFailure("Film id doesnt exist")
            return 0
        }
        return filmId
    }
    var type: Int {
        guard let type = aboutFilmPresenter?.type else {
            router.closeCurrentModule()
            assertionFailure("Type of page doesnt exist")
            return 0
        }
        return type
    }

    init(
        detailsFilmUsecase: IDetailsFilmUsecase,
        dataSourceForDetails: IDetailsFilmDataSourceInput,
        galleryUsecase: IGalleryUsecase,
        similarUsecase: ISimilarFilmsUsecase,
        dataSourceForSimilar: SimilarFilmsDataSourceInput,
        aboutFilmPresenter: AboutFilmInput,
        router: InfoRoutingInput
    ) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSourceForDetails = dataSourceForDetails
        self.galleryUsecase = galleryUsecase
        self.similarUsecase = similarUsecase
        self.dataSourceForSimilar = dataSourceForSimilar
        self.aboutFilmPresenter = aboutFilmPresenter
        self.router = router
    }

    func setDetailsFilm() {

        let url = aboutFilmPresenter?.type == 0 ? "movie" : "tv"

        detailsFilmUsecase.getFilmDetails(relativeURL: "/\(url)/\(id)").done { details in
            self.dataSourceForDetails.add(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {

        let url = aboutFilmPresenter?.type == 0 ? "movie" : "tv"

        galleryUsecase.getGallery(relativeURL: "/\(url)/\(id))/images").done { images in
            self.dataSourceForDetails.add(images: images)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setSimilar() {

        let url = aboutFilmPresenter?.type == 0 ? "movie" : "tv"

        similarUsecase.getSimilar(relativeURL: "/\(url)/\(id))/similar").done { films in
            self.dataSourceForSimilar.load(base: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

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
}

final class DetailsFilmPresenter: IDetailsFilmPresenter {

    private var detailsFilmUsecase: IDetailsFilmUsecase
    private var dataSource: IDetailsFilmDataSourceInput
    private var galleryUsecase: IGalleryUsecase

    init(
        detailsFilmUsecase: IDetailsFilmUsecase,
        dataSource: IDetailsFilmDataSourceInput,
        galleryUsecase: IGalleryUsecase
    ) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSource = dataSource
        self.galleryUsecase = galleryUsecase
    }

    func setDetailsFilm() {
        detailsFilmUsecase.getFilmDetails(relativeURL: "/movie/353081").done { details in
            self.dataSource.addDetails(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {
        galleryUsecase.getGallery(relativeURL: "/movie/353081/images").done { images in
            self.dataSource.addImages(images: images)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

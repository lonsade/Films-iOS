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
    func setCredits()
}

final class DetailsFilmPresenter: IDetailsFilmPresenter {

    private var detailsFilmUsecase: IDetailsFilmUsecase
    private var dataSource: IDetailsFilmDataSourceInput
    private var galleryUsecase: IGalleryUsecase
    private var castUsecase: ICastUsecase

    init(
        detailsFilmUsecase: IDetailsFilmUsecase,
        dataSource: IDetailsFilmDataSourceInput,
        galleryUsecase: IGalleryUsecase,
        castUsecase: ICastUsecase
    ) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSource = dataSource
        self.galleryUsecase = galleryUsecase
        self.castUsecase = castUsecase
    }

    func setDetailsFilm() {
        detailsFilmUsecase.getFilmDetails().done { details in
            self.dataSource.addDetails(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {
        galleryUsecase.getGallery().done { images in
            self.dataSource.addImages(images: images)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setCredits() {
        castUsecase.getCast().done { credits in
            self.dataSource.addCredits(credits: credits)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

//
//  ArtistBioPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IArtistBioPresenter: class {
    func setBio()
    func setGallery()
}

final class ArtistBioPresenter: IArtistBioPresenter {

    private var artistBioUsecase: IAboutArtistUsecase
    private var artistBioDataSource: IArtistBioDataSourceInput
    private var artistGalleryUsecase: IArtistPhotosUsecase

    init(
        artistBioUsecase: IAboutArtistUsecase,
        artistBioDataSource: IArtistBioDataSourceInput,
        artistGalleryUsecase: IArtistPhotosUsecase
    ) {
        self.artistBioUsecase = artistBioUsecase
        self.artistBioDataSource = artistBioDataSource
        self.artistGalleryUsecase = artistGalleryUsecase
    }

    func setBio() {

//        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        let castId = 287

        artistBioUsecase.getArtist(relativeURL: "/person/\(castId)").done { artist in
            self.artistBioDataSource.add(bio: artist)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {

//        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        let castId = 287

        artistGalleryUsecase.getPhotos(relativeURL: "/person/\(castId)/images").done { photos in
            self.artistBioDataSource.add(artistPhotos: photos)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

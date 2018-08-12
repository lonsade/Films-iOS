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
    private var castRouting: CastRoutingProtocolOutput
    private var artistGalleryUsecase: IArtistPhotosUsecase

    init(
        artistBioUsecase: IAboutArtistUsecase,
        artistBioDataSource: IArtistBioDataSourceInput,
        castRouting: CastRoutingProtocolOutput,
        artistGalleryUsecase: IArtistPhotosUsecase
    ) {
        self.artistBioUsecase = artistBioUsecase
        self.artistBioDataSource = artistBioDataSource
        self.castRouting = castRouting
        self.artistGalleryUsecase = artistGalleryUsecase
    }

    func setBio() {

        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        artistBioUsecase.getArtist(relativeURL: "/person/\(castId)").done { artist in
            self.artistBioDataSource.add(bio: artist)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {

        guard let castId = castRouting.selectArtistId else { fatalError("Cast id doesnt exist") }

        artistGalleryUsecase.getPhotos(relativeURL: "/person/\(castId)/images").done { photos in
            self.artistBioDataSource.add(artistPhotos: photos)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

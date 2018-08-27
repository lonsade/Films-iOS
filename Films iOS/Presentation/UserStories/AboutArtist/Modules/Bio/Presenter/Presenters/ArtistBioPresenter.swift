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
    private var router: ArtistBioRoutingInput
    private weak var aboutArtistPresenter: AboutArtistInput?

    init(
        artistBioUsecase: IAboutArtistUsecase,
        artistBioDataSource: IArtistBioDataSourceInput,
        artistGalleryUsecase: IArtistPhotosUsecase,
        aboutArtistPresenter: AboutArtistInput,
        router: ArtistBioRoutingInput
    ) {
        self.artistBioUsecase = artistBioUsecase
        self.artistBioDataSource = artistBioDataSource
        self.artistGalleryUsecase = artistGalleryUsecase
        self.aboutArtistPresenter = aboutArtistPresenter
        self.router = router
    }

    func setBio() {
        guard let artistId = aboutArtistPresenter?.id else {
            router.closeCurrentModule()
            return assertionFailure("Artist id doesnt exist")
        }

        artistBioUsecase.getArtist(relativeURL: "/person/\(artistId)").done { artist in
            self.artistBioDataSource.add(bio: artist)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

    func setGallery() {
        guard let artistId = aboutArtistPresenter?.id else {
            router.closeCurrentModule()
            return assertionFailure("Artist id doesnt exist")
        }

        artistGalleryUsecase.getPhotos(relativeURL: "/person/\(artistId)/images").done { photos in
            self.artistBioDataSource.add(artistPhotos: photos)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

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
}

final class ArtistBioPresenter: IArtistBioPresenter {

    private var artistBioUsecase: IAboutArtistUsecase
    private var artistBioDataSource: IArtistBioDataSourceInput
    private var castRouting: CastRoutingProtocolOutput

    init(
        artistBioUsecase: IAboutArtistUsecase,
        artistBioDataSource: IArtistBioDataSourceInput,
        castRouting: CastRoutingProtocolOutput
    ) {
        self.artistBioUsecase = artistBioUsecase
        self.artistBioDataSource = artistBioDataSource
        self.castRouting = castRouting
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

}

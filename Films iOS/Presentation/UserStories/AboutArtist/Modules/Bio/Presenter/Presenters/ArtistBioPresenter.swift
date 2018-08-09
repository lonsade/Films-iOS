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

    init(artistBioUsecase: IAboutArtistUsecase, artistBioDataSource: IArtistBioDataSourceInput) {
        self.artistBioUsecase = artistBioUsecase
        self.artistBioDataSource = artistBioDataSource
    }

    func setBio() {
        artistBioUsecase.getArtist().done { artist in
            self.artistBioDataSource.add(bio: artist)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

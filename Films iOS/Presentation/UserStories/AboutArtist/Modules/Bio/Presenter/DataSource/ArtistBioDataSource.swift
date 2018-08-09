//
//  ArtistBioDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IArtistBioDataSourceInput: class {
    func add(bio: Artist)
    func add(artistPhotos: [ArtistPhoto])
}

protocol IArtistBioDataSourceOutput: class {
    var bio: Artist? { get }
    var artistPhotos: [ArtistPhoto] { get }
    var delegate: ArtistBioDataSourceDelegate? { get set }
}

final class ArtistBioDataSource: IArtistBioDataSourceInput, IArtistBioDataSourceOutput {

    weak var delegate: ArtistBioDataSourceDelegate?

    func add(bio: Artist) {
        self.bio = bio
        delegate?.bioWasAdd(bio: bio)
    }
    func add(artistPhotos: [ArtistPhoto]) {
        self.artistPhotos = artistPhotos
        delegate?.photosWereAdd(photos: artistPhotos)
    }

    var artistPhotos: [ArtistPhoto]
    var bio: Artist?

    init() {
        artistPhotos = []
    }

}

protocol ArtistBioDataSourceDelegate: class {
    func bioWasAdd(bio: Artist)
    func photosWereAdd(photos: [ArtistPhoto])
}

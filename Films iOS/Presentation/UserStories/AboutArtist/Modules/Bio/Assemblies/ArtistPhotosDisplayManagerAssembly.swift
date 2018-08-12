//
//  ArtistPhotosDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistPhotosDisplayManagerAssembly: Assembly {

    lazy var artistBioDataSourceAssembly: ArtistBioDataSourceAssembly = ArtistBioDataSourceAssembly.instance()

    var artistPhotosDisplayManager: ArtistPhotosDisplayManager {
        return define(scope: .lazySingleton, init:
            ArtistPhotosDisplayManager(artistBioDataSource: self.artistBioDataSourceAssembly.artistBioDataSource)
        )
    }

}

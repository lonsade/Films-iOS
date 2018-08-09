//
//  ArtistBioDataSourceAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

final class ArtistBioDataSourceAssembly: Assembly {
    var artistBioDataSource: IArtistBioDataSourceOutput & IArtistBioDataSourceInput {
        return define(scope: .lazySingleton, init: ArtistBioDataSource())
    }
}

//
//  GalleryDisplayManagerAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class GalleryDisplayManagerAssembly: Assembly {

    lazy var detailsFilmDataSourceAssembly: DetailsFilmDataSourceAssembly = self.context.assembly()

    var galleryDisplayManager: GalleryDisplayManager {
        return define(scope: .lazySingleton, init:
            GalleryDisplayManager(detailFilm: self.detailsFilmDataSourceAssembly.detailsFilmDataSource)
        )
    }

}

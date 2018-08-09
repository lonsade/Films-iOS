//
//  ArtistViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class ArtistViewAssembly: Assembly {

    lazy var artistBioPresenterAssembly: ArtistBioPresenterAssembly = ArtistBioPresenterAssembly.instance()

    lazy var artistBioDataSourceAssembly: ArtistBioDataSourceAssembly = ArtistBioDataSourceAssembly.instance()

    func inject(into mvc: ArtistBioViewController) {
        defineInjection(into: mvc) {
            $0.artistBioPresenter = self.artistBioPresenterAssembly.artistBioPresenter
            $0.artistBioDataSource = self.artistBioDataSourceAssembly.artistBioDataSource
            return $0
        }
    }

}

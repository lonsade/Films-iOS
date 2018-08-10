//
//  CastRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol CastRoutingProtocol {
    func set(viewController: BaseViewController)
}

final class CastRouting: CastRoutingProtocol {

    private var currentViewController: BaseViewController?

    func set(viewController: BaseViewController) {
        currentViewController = viewController
    }

    private var castDisplayManager: CastDisplayManager

    private var castFilmDataSourceOutput: ICastFilmDataSourceOutput

    init (
        castDisplayManager: CastDisplayManager,
        castFilmDataSourceOutput: ICastFilmDataSourceOutput
    ) {
        self.castDisplayManager = castDisplayManager
        self.castFilmDataSourceOutput = castFilmDataSourceOutput
        castDisplayManager.delegate = self
    }

    var selectArtistId: Int?
}

extension CastRouting: FilmCastCollectionDisplayManager {
    func castWasSelected(at index: Int) {
        selectArtistId = castFilmDataSourceOutput.credits[index].id
        currentViewController?.openModule(withName: "AboutArtist")
    }
}

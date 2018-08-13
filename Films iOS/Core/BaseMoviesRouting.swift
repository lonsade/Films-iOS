//
//  BaseMoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol BaseMoviesRoutingProtocol: class {
    func set(viewController: BaseViewController)
}

protocol BaseMoviesRoutingOutput: class {
    var filmId: Int? { get }
}

class BaseMoviesRouting: BaseMoviesRoutingProtocol, BaseMoviesRoutingOutput {

    private var currentViewController: BaseViewController?

    var filmId: Int?

    func set(viewController: BaseViewController) {
        currentViewController = viewController
        filmCollectionDisplayManager.delegate = self
    }

    private var filmCollectionDisplayManager: BaseMoviesDisplayManager

    private var filmCollectionDataSource: BaseMoviesDataSourceOutput

    init (
        filmCollectionDisplayManager: BaseMoviesDisplayManager,
        filmCollectionDataSource: BaseMoviesDataSourceOutput
    ) {
        self.filmCollectionDisplayManager = filmCollectionDisplayManager
        self.filmCollectionDataSource = filmCollectionDataSource
    }
}

extension BaseMoviesRouting: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(at indexPath: IndexPath) {
        filmId = filmCollectionDataSource.films[indexPath.item].id
        currentViewController?.openModule(withName: "AboutFilm")
    }
}

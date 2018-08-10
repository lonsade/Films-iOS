//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol MoviesRoutingProtocol {
    func set(viewController: BaseViewController)
}

final class MoviesRouting: MoviesRoutingProtocol {

    private var currentViewController: BaseViewController?

    func set(viewController: BaseViewController) {
        currentViewController = viewController
    }

    private var filmCollectionDisplayManager: FilmCollectionDisplayManager

    private var filmCollectionDataSource: IListPopularDataSourceOutput

    init (
        filmCollectionDisplayManager: FilmCollectionDisplayManager,
        filmCollectionDataSource: IListPopularDataSourceOutput
    ) {
        self.filmCollectionDisplayManager = filmCollectionDisplayManager
        self.filmCollectionDataSource = filmCollectionDataSource
        filmCollectionDisplayManager.delegate = self
    }

    var selectFilmId: Int?
}

extension MoviesRouting: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(at indexPath: IndexPath) {
        selectFilmId = filmCollectionDataSource.films[indexPath.item].id

        currentViewController?.openModule(withName: "AboutFilm")

    }
}

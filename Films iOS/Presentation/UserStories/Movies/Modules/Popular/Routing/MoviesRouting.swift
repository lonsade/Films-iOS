//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

final class MoviesRouting {

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
        
        
    }
}

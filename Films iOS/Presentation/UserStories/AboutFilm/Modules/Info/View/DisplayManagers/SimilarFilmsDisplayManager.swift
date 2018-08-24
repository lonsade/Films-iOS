//
//  SimilarFilmsDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol SimilarFilmsDisplayManagerDelegate: class {
    func filmWasSelected(withIndex index: Int)
}

class SimilarFilmsDisplayManager: NSObject {

    private let reuseIdentifier = "filmCard"

    private var filmsDataSource: SimilarFilmsDataSourceOutput
    private var filmsPresenter: IDetailsFilmPresenter

    init(filmsDataSource: SimilarFilmsDataSourceOutput, filmsPresenter: IDetailsFilmPresenter) {
        self.filmsDataSource = filmsDataSource
        self.filmsPresenter = filmsPresenter
    }

    weak var delegate: ArtistMoviesDisplayManagerDelegate?

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.dataSource = self
            collectionFilms?.delegate = self
            filmsDataSource.delegate = self
        }
    }

}

extension SimilarFilmsDisplayManager: SimilarFilmsDataSourceDelegate {
    func baseWasAdd() {
        collectionFilms?.reloadData()
    }
}

extension SimilarFilmsDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withId: filmsDataSource.base[indexPath.item].id)
    }
}

extension SimilarFilmsDisplayManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmsDataSource.base.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
            ) as? FilmCollectionViewCell else { fatalError("Error cell FilmCollectionViewCell") }

        cell.setContent(
            image: filmsDataSource.base[indexPath.item].posterPath,
            title: filmsDataSource.base[indexPath.item].title,
            vote: filmsDataSource.base[indexPath.item].voteAverage,
            adult: filmsDataSource.base[indexPath.item].adult
        )

        return cell
    }

}

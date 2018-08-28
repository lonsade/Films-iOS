//
//  ArtistMoviesDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 24.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol ArtistMoviesDisplayManagerDelegate: class {
    func filmWasSelected(withId id: Int)
}

class ArtistMoviesDisplayManager: NSObject {

    private let reuseIdentifier = "filmCard"

    private var filmsDataSource: ArtistFilmsDataSourceOutput
    private var filmsPresenter: IArtistFilmsPresenter

    init(filmsDataSource: ArtistFilmsDataSourceOutput, filmsPresenter: IArtistFilmsPresenter) {
        self.filmsDataSource = filmsDataSource
        self.filmsPresenter = filmsPresenter
        super.init()
        filmsDataSource.delegate = self
    }

    weak var delegate: ArtistMoviesDisplayManagerDelegate?

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.dataSource = self
            collectionFilms?.delegate = self
            collectionFilms?.register(UINib(nibName: "FilmCard", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }

}

extension ArtistMoviesDisplayManager: ArtistFilmsDataSourceDelegate {
    func baseWasAdd() {
        collectionFilms?.reloadData()
    }
}

extension ArtistMoviesDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withId: filmsDataSource.base[indexPath.item].id)
    }
}

extension ArtistMoviesDisplayManager: UICollectionViewDataSource {

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
            title: filmsDataSource.base[indexPath.item].title ?? filmsDataSource.base[indexPath.item].name ?? L10n.notInformation,
            vote: filmsDataSource.base[indexPath.item].voteAverage,
            adult: filmsDataSource.base[indexPath.item].adult ?? false
        )

        return cell
    }

}

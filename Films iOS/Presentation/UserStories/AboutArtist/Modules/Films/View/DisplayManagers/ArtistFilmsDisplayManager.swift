//
//  ArtistFilmsDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit


// TODO: Фильмы без постера бросать вниз страницы (как в дизайне)


final class ArtistFilmsDisplayManager: NSObject {

    private let reuseIdentifier = "artistFilms"

    private var artistFilmsDataSource: IArtistFilmsDataSourceOutput

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.dataSource = self
            collectionFilms?.delegate = self
        }
    }

    init(artistFilmsDataSource: IArtistFilmsDataSourceOutput) {
        self.artistFilmsDataSource = artistFilmsDataSource
    }

    weak var delegate: FilmCollectionDisplayManagerDelegate?
}

extension ArtistFilmsDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(at: indexPath)
    }
}

extension ArtistFilmsDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistFilmsDataSource.artistFilms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? FilmCollectionViewCell else { fatalError("Error cell cast") }

        cell.setContent(
            image: artistFilmsDataSource.artistFilms[indexPath.item].posterPath,
            title: artistFilmsDataSource.artistFilms[indexPath.item].title,
            vote: artistFilmsDataSource.artistFilms[indexPath.item].voteAverage,
            age: artistFilmsDataSource.artistFilms[indexPath.item].id
        )

        return cell
    }

}

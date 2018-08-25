//
//  BaseMoviesDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol FilmCollectionDisplayManagerDelegate: class {
    func filmWasSelected(withId id: Int)
}

class BaseMoviesDisplayManager: NSObject {

    private let reuseIdentifier = "FilmCard"

    private var filmsDataSource: BaseMoviesDataSourceOutput
    private var filmsPresenter: IPopularFilmsPresenter

    init(filmsDataSource: BaseMoviesDataSourceOutput, filmsPresenter: IPopularFilmsPresenter) {
        self.filmsDataSource = filmsDataSource
        self.filmsPresenter = filmsPresenter
    }

    weak var delegate: FilmCollectionDisplayManagerDelegate?

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.dataSource = self
            collectionFilms?.delegate = self
            filmsDataSource.delegate = self

            collectionFilms?.register(UINib(nibName: "FilmCard", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        }
    }

}

extension BaseMoviesDisplayManager: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            filmsPresenter.setFilms()
        }

    }
}

extension BaseMoviesDisplayManager: BaseMoviesDataSourceDelegate {
    func moviesWereAdd() {

//        var indexPaths = [IndexPath]()
//
//        for index in firstIndex...lastIndex {
//            indexPaths.append(IndexPath(item: index, section: 0))
//        }
//
//
//        collectionFilms?.insertItems(at: indexPaths)

        collectionFilms?.reloadData()
    }
}

extension BaseMoviesDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withId: self.filmsDataSource.films[indexPath.item].id)
    }
}

extension BaseMoviesDisplayManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmsDataSource.films.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
            ) as? FilmCollectionViewCell else { fatalError("Error cell FilmCollectionViewCell") }

        cell.setContent(
            image: filmsDataSource.films[indexPath.item].posterPath,
            title: filmsDataSource.films[indexPath.item].title,
            vote: filmsDataSource.films[indexPath.item].voteAverage,
            adult: filmsDataSource.films[indexPath.item].adult
        )

        return cell
    }

}

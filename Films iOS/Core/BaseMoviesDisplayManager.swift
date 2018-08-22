//
//  BaseMoviesDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol FilmCollectionDisplayManagerDelegate: class {
    func filmWasSelected(withIndex index: Int)
}

class BaseMoviesDisplayManager: NSObject {

    private let reuseIdentifier = "filmCard"

    // для идентификации дисплея менеджера, предназначенного для отображения See Also
    var isSeeAlso = false

    private var filmsDataSource: BaseMoviesDataSourceOutput
    private var filmsPresenter: IFilmsPresenter

    init(filmsDataSource: BaseMoviesDataSourceOutput, filmsPresenter: IFilmsPresenter) {
        self.filmsDataSource = filmsDataSource
        self.filmsPresenter = filmsPresenter
    }

    weak var delegate: FilmCollectionDisplayManagerDelegate?

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.dataSource = self
            collectionFilms?.delegate = self
            filmsDataSource.delegate = self
        }
    }

}

extension BaseMoviesDisplayManager: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            filmsPresenter.loadPopularFilms(firstly: false)
        }

    }
}

extension BaseMoviesDisplayManager: BaseMoviesDataSourceDelegate {
    func moviesWereAdd() {
        collectionFilms?.reloadData()

        //* Фикс высоты коллекции для see also *//

//        if isSeeAlso {
//
//            let heightCell = 298
//
//            let space = 16
//
//            let countRows = filmsDataSource.films.count / 2
//
//            let heightCollection = heightCell * countRows + space * (countRows - 1)
//
//            let heightConstraint = NSLayoutConstraint(
//                item: collectionFilms,
//                attribute: .height,
//                relatedBy: .equal,
//                toItem: nil,
//                attribute: .notAnAttribute,
//                multiplier: 1,
//                constant: CGFloat(heightCollection)
//            )
//
//            collectionFilms?.addConstraint(heightConstraint)
//
//        }

    }
}

extension BaseMoviesDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withIndex: indexPath.item)
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
            age: filmsDataSource.films[indexPath.item].id
        )

        return cell
    }

}

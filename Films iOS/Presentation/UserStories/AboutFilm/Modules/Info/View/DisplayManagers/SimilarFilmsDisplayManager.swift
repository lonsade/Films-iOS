//
//  SimilarFilmsDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class SimilarFilmsDisplayManager: NSObject {

    private let reuseIdentifier = "similar"

    private var detailFilm: IDetailsFilmDataSourceOutput

    weak var collectionSimilar: UICollectionView? {
        didSet {
            //detailFilm.infoDelegate = self
            collectionSimilar?.delegate = self
            collectionSimilar?.dataSource = self
            collectionSimilar?.showsVerticalScrollIndicator = false
        }
    }

    //weak var delegate: FilmDetailCollectionDisplayManager?

    init(detailFilm: IDetailsFilmDataSourceOutput) {
        self.detailFilm = detailFilm
    }

}

extension SimilarFilmsDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension SimilarFilmsDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailFilm.similar.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? FilmCollectionViewCell else { fatalError("Error cell card film cell") }

        cell.setContent(
            image: detailFilm.similar[indexPath.item].posterPath,
            title: detailFilm.similar[indexPath.item].title,
            vote: detailFilm.similar[indexPath.item].voteAverage,
            age: detailFilm.similar[indexPath.item].id
        )

        return cell
    }

}

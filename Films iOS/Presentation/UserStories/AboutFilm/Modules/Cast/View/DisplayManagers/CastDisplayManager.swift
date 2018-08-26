//
//  CastDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol FilmCastCollectionDisplayManager: class {
    func castWasSelected(withId id: Int)
}

final class CastDisplayManager: NSObject {

    private let reuseIdentifier = "cast"

    private var castDataSource: ICastFilmDataSourceOutput

    weak var collectionCast: UICollectionView? {
        didSet {
            collectionCast?.delegate = self
            collectionCast?.dataSource = self
            collectionCast?.showsVerticalScrollIndicator = false
        }
    }

    weak var delegate: FilmCastCollectionDisplayManager?

    init(castDataSource: ICastFilmDataSourceOutput) {
        self.castDataSource = castDataSource
        super.init()
        castDataSource.delegate = self
    }

}

extension CastDisplayManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.castWasSelected(withId: self.castDataSource.credits[indexPath.item].id)
    }
}

extension CastDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.castDataSource.credits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? CastCollectionCell else { fatalError("Error cell cast") }

        cell.setContent(
            image: self.castDataSource.credits[indexPath.item].profilePath,
            name: self.castDataSource.credits[indexPath.item].name
        )

        return cell
    }

}

extension CastDisplayManager: CastFilmDataSourceCastDelegate {
    func creditsWasAdded(credits: [Cast]) {
        collectionCast?.reloadData()
    }
}

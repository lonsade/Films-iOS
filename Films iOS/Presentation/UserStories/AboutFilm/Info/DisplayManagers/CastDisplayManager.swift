//
//  CastDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class CastDisplayManager: NSObject {

    private let reuseIdentifier = "cast"

    private var castDataSource: IDetailsFilmDataSourceOutput

    weak var collectionCast: UICollectionView? {
        didSet {
            castDataSource.castDelegate = self
            //collectionCast?.delegate = self
            collectionCast?.dataSource = self
            collectionCast?.showsVerticalScrollIndicator = false
        }
    }

    //weak var delegate: FilmDetailCollectionDisplayManager?

    init(castDataSource: IDetailsFilmDataSourceOutput) {
        self.castDataSource = castDataSource
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

extension CastDisplayManager: DetailsFilmDataSourceCastDelegate {
    func creditsWasAdded(credits: [Cast]) {
        collectionCast?.reloadData()
    }
}

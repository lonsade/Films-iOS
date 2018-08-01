//
//  FilmCollectionDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol FilmCollectionDisplayManagerDelegate: class {
    func filmWasSelected(at indexPath: IndexPath)
}

final class FilmCollectionDisplayManager: NSObject {

    private let reuseIdentifier = "filmCard"

    private var filmCards: [FilmCard] = [
        FilmCard(urlPoster: "examplePoster", title: "title1", voteAverage: 1.1, age: 6),
        FilmCard(urlPoster: "examplePoster", title: "title2", voteAverage: 1.2, age: 7),
        FilmCard(urlPoster: "examplePoster", title: "title3", voteAverage: 1.3, age: 8),
        FilmCard(urlPoster: "examplePoster", title: "title4", voteAverage: 1.4, age: 9)
    ]

    weak var collectionFilms: UICollectionView? {
        didSet {
            collectionFilms?.delegate = self
            collectionFilms?.dataSource = self
        }
    }

    weak var delegate: FilmCollectionDisplayManagerDelegate?

}

extension FilmCollectionDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? FilmCollectionViewCell else { fatalError("Error cell film") }

        cell.imagePoster.image = UIImage(named: filmCards[indexPath.item].urlPoster)!
        cell.setTextForTitle(text: filmCards[indexPath.item].title)
        cell.setTextForAge(age: filmCards[indexPath.item].age)
        cell.setTextForVoteAverage(vote: filmCards[indexPath.item].voteAverage)

        cell.backgroundColor = UIColor.FBackgroundColorPoster

        return cell
    }

}

extension FilmCollectionDisplayManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(at: indexPath)
    }
}

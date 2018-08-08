//
//  GalleryDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class GalleryDisplayManager: NSObject {

    private let reuseIdentifier = "images"

//    private var listPopularDataSource: IListPopularDataSourceOutput
//
//    weak var collectionFilms: UICollectionView? {
//        didSet {
//            listPopularDataSource.delegate = self
//            collectionFilms?.delegate = self
//            collectionFilms?.dataSource = self
//            collectionFilms?.showsVerticalScrollIndicator = false
//        }
//    }
//
//    weak var delegate: FilmCollectionDisplayManagerDelegate?
//
//    init(listPopularDataSource: IListPopularDataSourceOutput) {
//        self.listPopularDataSource = listPopularDataSource
//    }

}

//extension FilmCollectionDisplayManager: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.listPopularDataSource.films.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: self.reuseIdentifier,
//            for: indexPath
//            ) as? FilmCollectionViewCell else { fatalError("Error cell film") }
//
//        cell.setContent(
//            image: self.listPopularDataSource.films[indexPath.item].posterPath,
//            title: self.listPopularDataSource.films[indexPath.item].title,
//            vote: self.listPopularDataSource.films[indexPath.item].voteAverage,
//            age: self.listPopularDataSource.films[indexPath.item].id)
//
//        return cell
//    }
//
//}

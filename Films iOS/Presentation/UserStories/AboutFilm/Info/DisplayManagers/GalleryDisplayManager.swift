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

    private var detailFilm: IDetailsFilmDataSourceOutput

    weak var collectionGallery: UICollectionView? {
        didSet {
            //detailFilm.infoDelegate = self
            //collectionGallery?.delegate = self
            collectionGallery?.dataSource = self
            collectionGallery?.showsVerticalScrollIndicator = false
        }
    }

    //weak var delegate: FilmDetailCollectionDisplayManager?

    init(detailFilm: IDetailsFilmDataSourceOutput) {
        self.detailFilm = detailFilm
    }

}

extension GalleryDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailFilm.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? GalleryCollectionCell else { fatalError("Error cell gallery image") }

        cell.setImage(imageUrl: detailFilm.images[indexPath.item].filePath)

        return cell
    }

}

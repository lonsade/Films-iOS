//
//  GalleryDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 08.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class GalleryDisplayManager: NSObject {

    private var detailFilm: IDetailsFilmDataSourceOutput

    weak var collectionGallery: UICollectionView? {
        didSet {
            collectionGallery?.dataSource = self

            collectionGallery?.register(
                UINib(nibName: "GalleryCollectionCell", bundle: nil),
                forCellWithReuseIdentifier: "GalleryCollectionCell"
            )

        }
    }

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
            withReuseIdentifier: "GalleryCollectionCell",
            for: indexPath
        ) as? GalleryCollectionCell else { fatalError("Error cell gallery image") }

        cell.setImage(imageUrl: detailFilm.images[indexPath.item].filePath)

        return cell
    }

}

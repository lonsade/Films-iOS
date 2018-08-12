//
//  ArtistPhotosDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class ArtistPhotosDisplayManager: NSObject {

    private let reuseIdentifier = "artistPhotos"

    private var artistBioDataSource: IArtistBioDataSourceOutput

    weak var collectionPhotos: UICollectionView? {
        didSet {
            collectionPhotos?.dataSource = self
            collectionPhotos?.showsVerticalScrollIndicator = false
        }
    }

    init(artistBioDataSource: IArtistBioDataSourceOutput) {
        self.artistBioDataSource = artistBioDataSource
    }

}

extension ArtistPhotosDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistBioDataSource.artistPhotos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? ArtistPhotosCollectionViewCell else { fatalError("Error cell cast") }

        cell.setImage(imageUrl: artistBioDataSource.artistPhotos[indexPath.item].filePath)

        return cell
    }

}

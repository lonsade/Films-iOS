//
//  InfoFilmDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class InfoFilmDisplayManager: NSObject {

    private var detailFilm: IDetailsFilmDataSourceOutput

    private var galleryDisplayManager: GalleryDisplayManager

    weak var infoFilmCollectionView: UICollectionView? {
        didSet {
            infoFilmCollectionView?.delegate = self
            infoFilmCollectionView?.dataSource = self

            detailFilm.delegate = self

            infoFilmCollectionView?.register(
                UINib(nibName: "FilmVideos", bundle: nil),
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: "FilmVideos"
            )
            infoFilmCollectionView?.register(
                UINib(nibName: "FilmInfo", bundle: nil),
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: "FilmInfo"
            )
            infoFilmCollectionView?.register(
                UINib(nibName: "FilmGallery", bundle: nil),
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                withReuseIdentifier: "FilmGallery"
            )
        }
    }

    //weak var delegate: FilmDetailCollectionDisplayManager?

    init(detailFilm: IDetailsFilmDataSourceOutput, galleryDisplayManager: GalleryDisplayManager) {
        self.detailFilm = detailFilm
        self.galleryDisplayManager = galleryDisplayManager
    }

}

extension InfoFilmDisplayManager: DetailsFilmDataSourceDelegate {
    func detailsWasAdded(details: FilmDetail) {
        infoFilmCollectionView?.reloadData()
    }

    func imagesWasAdded(images: [GalleryImage]) {
        infoFilmCollectionView?.reloadData()
    }
}

extension InfoFilmDisplayManager: UICollectionViewDelegate {

}

extension InfoFilmDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
//        if let galleryCell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: "GalleryCollectionCell",
//            for: indexPath
//        ) as? GalleryCollectionCell {
//            galleryCell.setImage(imageUrl: detailFilm.images[indexPath.item].filePath)
//            cell = galleryCell
//        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        var reusableview = UICollectionReusableView()
        if (kind == UICollectionElementKindSectionHeader) {
            switch (indexPath.section) {
            case 0:
                guard let filmVideos = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmVideos", for: indexPath) as? FilmVideos else { fatalError("") }

                reusableview = filmVideos
            case 1:
                guard let filmInfo = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmInfo", for: indexPath) as? FilmInfo else { fatalError("") }

                if let details = detailFilm.details {
                    filmInfo.set(details: details)
                }

                reusableview = filmInfo
            case 2:
                guard let filmGallery = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmGallery", for: indexPath) as? FilmGallery else { fatalError("") }

                if !detailFilm.images.isEmpty {
                    galleryDisplayManager.collectionGallery = filmGallery.galleryCollectionView
                }
                reusableview = filmGallery
            default:
                return reusableview

            }
        }
        return reusableview
    }
}

extension InfoFilmDisplayManager: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 150)
        } else if section == 1 {
            if let details = detailFilm.details, let info = details.overview {

                let height = UILabel.size(
                    withText: info,
                    forWidth: collectionView.frame.width - 55,
                    withFont: .FAboutFilmInfoTitleAndDesc).height

                return CGSize(
                    width: collectionView.frame.size.width,
                    height: 180 + height
                )

            } else {
                return CGSize(width: collectionView.frame.size.width, height: 200)
            }
        } else if section == 2 {

            let hLabel: CGFloat = 24
            let hConstraint1: CGFloat = 14
            let hConstraint2: CGFloat = 11
            let hcollection: CGFloat = 60

            return CGSize(width: collectionView.frame.size.width, height: hLabel + hConstraint1 + hConstraint2 + hcollection)
        }
        return CGSize(width: collectionView.frame.size.width, height: 0)
    }
}

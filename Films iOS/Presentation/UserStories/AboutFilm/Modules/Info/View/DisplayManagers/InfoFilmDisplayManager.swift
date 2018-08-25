//
//  InfoFilmDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

final class InfoFilmDisplayManager: NSObject {

//    private let reuseIdentifier = "images"

    private var detailFilm: IDetailsFilmDataSourceOutput

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

        }
    }

    //weak var delegate: FilmDetailCollectionDisplayManager?

    init(detailFilm: IDetailsFilmDataSourceOutput) {
        self.detailFilm = detailFilm
    }

}

extension InfoFilmDisplayManager: DetailsFilmDataSourceDelegate {
    func detailsWasAdded(details: FilmDetail) {
        infoFilmCollectionView?.reloadData()
//        infoFilmCollectionView?.reloadInputViews()
//        infoFilmCollectionView?.sizeToFit()
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
        fatalError("")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
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
                guard let firstheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmVideos", for: indexPath) as? FilmVideos else { fatalError("") }

                reusableview = firstheader
            case 1:
                guard let secondHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmInfo", for: indexPath) as? FilmInfo else { fatalError("") }

                if let details = detailFilm.details {
                    secondHeader.set(details: details)
                }

                reusableview = secondHeader
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
        }
        return CGSize(width: collectionView.frame.size.width, height: 0)
    }
}

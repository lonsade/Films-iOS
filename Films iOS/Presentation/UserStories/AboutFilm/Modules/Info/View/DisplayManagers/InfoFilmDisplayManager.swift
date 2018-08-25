//
//  InfoFilmDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 25.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol InfoFilmDisplayManagerDelegate: class {
    func filmWasSelected(withId id: Int)
}

final class InfoFilmDisplayManager: NSObject {

    private var detailFilm: IDetailsFilmDataSourceOutput

    private var galleryDisplayManager: GalleryDisplayManager

    private var filmsDataSource: SimilarFilmsDataSourceOutput

    private var filmsPresenter: IDetailsFilmPresenter

    weak var infoFilmCollectionView: UICollectionView? {
        didSet {
            infoFilmCollectionView?.delegate = self
            infoFilmCollectionView?.dataSource = self

            detailFilm.delegate = self
            filmsDataSource.delegate = self

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

            infoFilmCollectionView?.register(UINib(nibName: "FilmCard", bundle: nil), forCellWithReuseIdentifier: "filmCard")
        }
    }

    weak var delegate: InfoFilmDisplayManagerDelegate?

    init(
        detailFilm: IDetailsFilmDataSourceOutput,
        galleryDisplayManager: GalleryDisplayManager,
        filmsDataSource: SimilarFilmsDataSourceOutput,
        filmsPresenter: IDetailsFilmPresenter
    ) {
        self.detailFilm = detailFilm
        self.galleryDisplayManager = galleryDisplayManager
        self.filmsDataSource = filmsDataSource
        self.filmsPresenter = filmsPresenter
    }

}

extension InfoFilmDisplayManager: SimilarFilmsDataSourceDelegate {
    func baseWasAdd() {
        infoFilmCollectionView?.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withId: filmsDataSource.base[indexPath.item].id)
    }
}

extension InfoFilmDisplayManager: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            filmsPresenter.setSimilar()
        }

    }
}

extension InfoFilmDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if section == 3 {
            return filmsDataSource.base.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let filmCardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "filmCard",
            for: indexPath
        ) as? FilmCollectionViewCell {

            filmCardCell.setContent(
                image: filmsDataSource.base[indexPath.item].posterPath,
                title: filmsDataSource.base[indexPath.item].title,
                vote: filmsDataSource.base[indexPath.item].voteAverage,
                adult: filmsDataSource.base[indexPath.item].adult
            )

            cell = filmCardCell
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
                guard let filmVideos = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "FilmVideos",
                    for: indexPath
                ) as? FilmVideos else { fatalError("") }

                reusableview = filmVideos
            case 1:
                guard let filmInfo = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "FilmInfo",
                    for: indexPath
                ) as? FilmInfo else { fatalError("") }

                if let details = detailFilm.details {
                    filmInfo.set(details: details)
                }

                reusableview = filmInfo
            case 2:
                guard let filmGallery = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "FilmGallery",
                    for: indexPath
                ) as? FilmGallery else { fatalError("") }

                if !detailFilm.images.isEmpty {
                    galleryDisplayManager.collectionGallery = filmGallery.galleryCollectionView
                } else {
//                    filmGallery.galleryCollectionView.isHidden = true
//                    filmGallery.galleryLabel.isHidden = true
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
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        if section == 3 {
            return UIEdgeInsets(top: 11, left: 16, bottom: 16, right: 16)
        }
        return UIEdgeInsets.zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 {

            if let details = detailFilm.details, details.video {
                return CGSize(width: collectionView.frame.size.width, height: 150)
            } else {
                return CGSize(width: 0, height: 0)
            }
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

            let hLabel: CGFloat = 24 * 2
            let hConstraint1: CGFloat = 14
            let hConstraint2: CGFloat = 11
            let hConstraint3: CGFloat = 18
            let hcollection: CGFloat = 60

            return CGSize(width: collectionView.frame.size.width, height: hLabel + hConstraint1 + hConstraint2 + hcollection + hConstraint3)
        }
        return CGSize(width: collectionView.frame.size.width, height: 0)
    }
}

//
//  ArtistBioViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class ArtistBioViewController: BaseViewController {

    @IBOutlet weak var artistImageView: UIImageView! {
        didSet {
            artistImageView.setCornerRadius(byRoundingCorners: [.allCorners], size: 8)
        }
    }
    @IBOutlet weak var artistNameLabel: UILabel! {
        didSet {
            artistNameLabel.font = .FArtistName
            artistNameLabel.textColor = .FTitleTextColor
        }
    }
    @IBOutlet weak var titleBirthdayLabel: UILabel! {
        didSet {
            titleBirthdayLabel.font = .FAboutFilmInfoTitleAndDesc
            titleBirthdayLabel.textColor = .FContentTextColor
        }
    }
    @IBOutlet weak var artistBirthdayLabel: UILabel! {
        didSet {
            artistBirthdayLabel.font = .FTabName
            artistBirthdayLabel.textColor = .FTitleTextColor
        }
    }
    @IBOutlet weak var titlePlaceOfBirthLabel: UILabel! {
        didSet {
            titlePlaceOfBirthLabel.font = .FAboutFilmInfoTitleAndDesc
            titlePlaceOfBirthLabel.textColor = .FContentTextColor
        }
    }
    @IBOutlet weak var artistPlaceOfBirthLabel: UILabel! {
        didSet {
            artistPlaceOfBirthLabel.font = .FTabName
            artistPlaceOfBirthLabel.textColor = .FTitleTextColor
        }
    }
    @IBOutlet weak var artistBioTextView: UITextView! {
        didSet {
            artistBioTextView.font = .FAboutFilmInfoTitleAndDesc
            artistBioTextView.textColor = .FContentTextColor
            artistBioTextView.textContainerInset = .zero
            artistBioTextView.textContainer.lineFragmentPadding = 0
        }
    }
    @IBOutlet weak var titlePhotosLabel: UILabel! {
        didSet {
            titlePhotosLabel.font = .FTabName
            titlePhotosLabel.textColor = .FTitleTextColor
        }
    }
    @IBOutlet weak var artistPhotosCollectionView: UICollectionView!

    var artistBioDataSource: IArtistBioDataSourceOutput! {
        didSet {
            artistBioDataSource.delegate = self
        }
    }

    var artistBioPresenter: IArtistBioPresenter!
    var router: ArtistBioRoutingInput!

    var artistPhotosDisplayManager: ArtistPhotosDisplayManager! {
        didSet {
            artistPhotosDisplayManager.collectionPhotos = artistPhotosCollectionView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.FMainBackgroundColor
        ArtistBioAssembly.instance().inject(into: self)
        router.viewController = self
        artistBioPresenter.setBio()
        artistBioPresenter.setGallery()
    }
}

extension ArtistBioViewController: ArtistBioDataSourceDelegate {
    func bioWasAdd(bio: Artist) {
        artistNameLabel.text = bio.name

        artistBirthdayLabel.text = bio.birthday?.getStringDate(newFormat: "yyyy, d MMMM", oldFormat: "yyyy-MM-dd") ?? L10n.notInformation

        artistPlaceOfBirthLabel.text = bio.placeOfBirth ?? L10n.notInformation

        artistBioTextView.text = bio.biography

        artistImageView.downloadedFrom(link: bio.profilePath, contentMode: .scaleAspectFill)
    }

    func photosWereAdd() {
        artistPhotosDisplayManager.collectionPhotos?.reloadData()
    }
}

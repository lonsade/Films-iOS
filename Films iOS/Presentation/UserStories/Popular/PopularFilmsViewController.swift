//
//  PopularFilmsViewController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

class PopularFilmsViewController: UIViewController {

    @IBOutlet weak var filmCollection: UICollectionView!

    private var filmCollectionDisplayManager: FilmCollectionDisplayManager! {
        didSet {
            filmCollectionDisplayManager.collectionFilms = filmCollection
            filmCollectionDisplayManager.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        filmCollectionDisplayManager = FilmCollectionDisplayManager()

        // Do any additional setup after loading the view.
    }

}

extension PopularFilmsViewController: FilmCollectionDisplayManagerDelegate {
    func filmWasSelected(at indexPath: IndexPath) {
        return
    }

}

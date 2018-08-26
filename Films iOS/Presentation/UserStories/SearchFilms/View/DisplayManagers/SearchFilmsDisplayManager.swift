//
//  SearchFilmsDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol SearchFilmsDisplayManagerDelegate: class {
    func filmWasSelected(withId id: Int)
}

final class SearchFilmsDisplayManager: NSObject {
    
    private var dataSource: SearchFilmsDataSourceOutput
    
    weak var delegate: SearchFilmsDisplayManagerDelegate?
    
    weak var collectionSearchFilm: UICollectionView? {
        didSet {
            collectionSearchFilm?.dataSource = self
            collectionSearchFilm?.delegate = self
        }
    }
    
    init(dataSource: SearchFilmsDataSourceOutput) {
        self.dataSource = dataSource
    }
    
}

extension SearchFilmsDisplayManager: UICollectionViewDelegate {
    
}

extension SearchFilmsDisplayManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

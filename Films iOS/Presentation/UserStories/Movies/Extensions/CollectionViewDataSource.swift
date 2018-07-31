//
//  CollectionViewDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabNames.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath as IndexPath
        ) as! TabNameCollectionViewCell
        cell.tabName.setTitle(tabNames[indexPath.item], for: .normal)
        cell.tabName.setTitleColor(UIColor.FContentTextColor, for: .normal)
        return cell
    }
}

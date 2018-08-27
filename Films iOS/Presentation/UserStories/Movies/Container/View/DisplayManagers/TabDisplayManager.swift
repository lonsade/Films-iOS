//
//  TabDisplayManager.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol TabDisplayManagerDelegate: class {
    func tabWasSelected(at indexPath: IndexPath)
}

final class TabDisplayManager: NSObject {

    private let reuseIdentifier = "tabName"

    private var tabNamesDataSource: ITabNamesDataSourceOutput

    weak var collectionTabNames: UICollectionView? {
        didSet {
            collectionTabNames?.delegate = self
            collectionTabNames?.dataSource = self
        }
    }

    weak var delegate: TabDisplayManagerDelegate?

    init(tabNamesDataSource: ITabNamesDataSourceOutput) {
        self.tabNamesDataSource = tabNamesDataSource
    }
}

extension TabDisplayManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tabNamesDataSource.names.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: self.reuseIdentifier,
            for: indexPath
        ) as? TabNameCollectionViewCell else { fatalError("Error cell tab name") }

        cell.setTitle(title: tabNamesDataSource.names[indexPath.item].name)
        return cell
    }

}

extension TabDisplayManager: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tabWasSelected(at: indexPath)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: tabNamesDataSource.names[indexPath.item].name.getSizeWithFormating(font: UIFont.FTabName).width + 20,
            height: 32
        )
    }
}

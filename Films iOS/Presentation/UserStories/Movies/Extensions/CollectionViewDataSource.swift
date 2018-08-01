//
//  CollectionViewDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

// TODO: Вынести всю работу с коллекцией в отдельный класс.
//
// Вот пример того, как это может выглядеть.
//
//protocol TabDisplayManagerDelegate: class {
//    func tabWasSelected(at index: Int)
//}
//
//final class TabDisplayManager: NSObject {
//
//    private let reuseIdentifier = "tabName"
//    private var tabNamesString = ["IN CINEMA", "POPULAR", "COMEDIES", "DRAMA", "HISTORICAL"]
//
//    lazy var tabNames: [NSAttributedString] = {
//        var temp = [NSAttributedString]()
//        for str in tabNamesString {
//            temp.append(NSAttributedString(
//                string: str,
//                attributes: [
//                    .foregroundColor: UIColor.FTabNameColor,
//                    .font: UIFont.FTabName
//                ]
//            ))
//        }
//        return temp
//    }()
//
//    weak var collectionTabNames: UICollectionView? {
//        didSet {
//            collectionTabNames?.delegate = self
//            collectionTabNames?.dataSource = self
//        }
//    }
//
//    weak var delegate: TabDisplayManagerDelegate?
//
//}
//
//extension TabDisplayManager: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.tabNames.count
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: self.reuseIdentifier,
//            for: indexPath
//        ) as! TabNameCollectionViewCell
//        cell.tabName.setAttributedTitle(tabNames[indexPath.item], for: .normal)
//        return cell
//    }
//
//}
//
//extension TabDisplayManager: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.tabWasSelected(at: indexPath.item)
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        return CGSize(width: tabNames[indexPath.row].size().width + 20, height: 32)
//    }
//}

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
            for: indexPath
        ) as! TabNameCollectionViewCell

        // TODO: Желательно эту кастомизацию перенести в саму ячейку, и сделать у неё метод,
        // который принимает только обычную строку. Тогда сама ячейка будет делать из неё NSAttributedString, применять шрифты и т.д.
        cell.tabName.setAttributedTitle(tabNames[indexPath.item], for: .normal)
        return cell
    }
}

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

protocol SearchFilmsDisplayManagerOutput: class {
    var delegate: SearchFilmsDisplayManagerDelegate? { get set }
    var searchFilmsTableView: UITableView? { get set }
}

final class SearchFilmsDisplayManager: NSObject, SearchFilmsDisplayManagerOutput {

    private var dataSource: SearchFilmsDataSourceOutput
    private var presenter: SearchFilmsPresenterInput

    weak var delegate: SearchFilmsDisplayManagerDelegate?

    weak var searchFilmsTableView: UITableView? {
        didSet {
            searchFilmsTableView?.dataSource = self
            searchFilmsTableView?.delegate = self
            dataSource.delegate = self
        }
    }

    init(dataSource: SearchFilmsDataSourceOutput, presenter: SearchFilmsPresenterInput) {
        self.dataSource = dataSource
        self.presenter = presenter
    }

    private var itemCount = 0

}

extension SearchFilmsDisplayManager: SearchFilmsDataSourceDelegate {
    func filmsWereAdd(withIndex firstIndex: Int, underIndex lastIndex: Int) {
        searchFilmsTableView?.performBatchUpdates({
            for index in firstIndex...lastIndex {
                searchFilmsTableView?.insertRows(at: [IndexPath(item: index, section: 0)], with: .none)
                itemCount += 1
            }
        }, completion: nil)
    }
}

extension SearchFilmsDisplayManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFilmCell", for: indexPath) as? SearchFilmCell else {
            fatalError("Error table cell of SearchFilmCell")
        }
        cell.setContent(
            image: dataSource.data[indexPath.item].posterPath,
            title: dataSource.data[indexPath.item].title,
            overview: dataSource.data[indexPath.item].overview,
            vote: dataSource.data[indexPath.item].voteAverage,
            adult: dataSource.data[indexPath.item].adult
        )

        return cell
    }
}

extension SearchFilmsDisplayManager: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            presenter.loadMore()
        }

    }
}

extension SearchFilmsDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.filmWasSelected(withId: dataSource.data[indexPath.item].id)
    }
}

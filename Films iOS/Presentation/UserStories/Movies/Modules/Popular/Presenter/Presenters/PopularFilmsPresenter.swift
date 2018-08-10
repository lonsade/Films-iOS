//
//  PopularFilmsPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IPopularFilmsPresenter: class {
    func setPopularFilms()
}

final class PopularFilmsPresenter: IPopularFilmsPresenter {

    private var listPopularFilmsUsecase: IListPopularFilmsUsecase
    private var dataSource: IListPopularDataSourceInput

    init(listPopularFilmsUsecase: IListPopularFilmsUsecase, dataSource: IListPopularDataSourceInput) {
        self.listPopularFilmsUsecase = listPopularFilmsUsecase
        self.dataSource = dataSource
    }

    func setPopularFilms() {
        listPopularFilmsUsecase.getPopularFilms().done { films in
            self.dataSource.addFilms(films: films)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

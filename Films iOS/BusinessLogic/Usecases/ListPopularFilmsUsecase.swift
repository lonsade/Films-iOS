//
//  ListPopularFilmsUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IListPopularFilmsUsecase: class {
    func getPopularFilms() -> Promise<[FilmCard]>
}

final class ListPopularFilmsUsecase: IListPopularFilmsUsecase {

    private var listPopularFilmsGateway: IListPopularFilmsGateway

    init(listPopularFilmsGateway: IListPopularFilmsGateway) {
        self.listPopularFilmsGateway = listPopularFilmsGateway
    }

    func getPopularFilms() -> Promise<[FilmCard]> {
        return listPopularFilmsGateway.getPopularFilms()
    }
}

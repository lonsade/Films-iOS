//
//  PopularFilmsDSAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

final class PopularFilmsDSAssembly: Assembly {
    var popularFilmsDS: IListPopularDataSourceOutput & IListPopularDataSourceInput {
        return define(scope: .lazySingleton, init: ListPopularDataSource())
    }
}

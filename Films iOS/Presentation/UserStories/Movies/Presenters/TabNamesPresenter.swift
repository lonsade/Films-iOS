//
//  TabNamesPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 03.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

final class TabNamesPresenter {
    private let tabNamesUsecase: ITabNamesUsecase

    private let dataSource: IDataSource

    init(tabNamesUsecase: ITabNamesUsecase, dataSource: IDataSource) {
        self.tabNamesUsecase = tabNamesUsecase
        self.dataSource = dataSource
    }

    
    
}

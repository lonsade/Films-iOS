//
//  TabNamesPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 03.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ITabNamesPresenter: class {
    func setTabNames()
}

final class TabNamesPresenter: ITabNamesPresenter {

    private var tabNamesUsecase: ITabNamesUsecase
    private var dataSource: ITabNamesDataSourceInput

    init(tabNamesUsecase: ITabNamesUsecase, dataSource: ITabNamesDataSourceInput) {
        self.tabNamesUsecase = tabNamesUsecase
        self.dataSource = dataSource
    }

    func setTabNames() {
        tabNamesUsecase.getTabNames().done { tabNames in
            self.dataSource.addNames(names: tabNames)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }

}

//
//  MainViewAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import EasyDi

class MainViewAssembly: Assembly {

    lazy var tabNamesUsecaseAssembly: TabNamesUsecaseAssembly = self.context.assembly()

    func inject(into vc: MainViewController) {
        defineInjection(into: vc) {
            $0.tabNamesUsecase = self.tabNamesUsecaseAssembly.tabNamesUsecase
            return $0
        }
    }
}

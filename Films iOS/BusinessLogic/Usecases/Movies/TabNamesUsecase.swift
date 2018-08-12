//
//  TabNamesUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol ITabNamesUsecase: class {
    func getTabNames(relativeURL: String) -> Promise<[TabName]>
}

final class TabNamesUsecase: ITabNamesUsecase {

    private var makeRequestGatewayTabNames: IMakeRequestGateway

    init(makeRequestGatewayTabNames: IMakeRequestGateway) {
        self.makeRequestGatewayTabNames = makeRequestGatewayTabNames
    }

    func getTabNames(relativeURL: String) -> Promise<[TabName]> {
        return Promise<[TabName]> { seal in
            makeRequestGatewayTabNames.getResults(relativeURL: relativeURL).done { (tabs: Genres) in
                seal.fulfill(tabs.genres)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
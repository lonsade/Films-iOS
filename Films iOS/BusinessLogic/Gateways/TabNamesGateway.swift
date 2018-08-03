//
//  TabNamesGateway.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol ITabNamesGateway: class {
    func getTabNames() -> Promise<[TabName]>
}

final class TabNamesGateway: ITabNamesGateway {

    private var networking: NetworkingProtocol
    private var parameters: [String: Any]?
    private var relativeURL: String
    private var headers: [String: String]?
    private var method: RequestMethod

    init(
        networking: NetworkingProtocol,
        relativeURL: String,
        parameters: [String: Any]?,
        headers: [String: String]?,
        method: RequestMethod
    ) {
        self.networking = networking
        self.relativeURL = relativeURL
        self.parameters = parameters
        self.headers = headers
        self.method = method
    }

    func getTabNames() -> Promise<[TabName]> {
        return Promise<[TabName]> { seal in
            var tabNames: [TabName] = []
            networking.request(
                method: method,
                relativeURL,
                parameters: parameters,
                headers: headers
            ).done { (result: Genres) in
                result.genres.forEach { tabName in
                    tabNames.append(tabName)
                }
                seal.fulfill(tabNames)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}

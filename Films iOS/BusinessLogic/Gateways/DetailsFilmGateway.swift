//
//  DetailsFilmGateway.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IDetailsFilmGateway: class {
    func getFilmDetails() -> Promise<FilmDetail>
}

final class DetailsFilmGateway: IDetailsFilmGateway {

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

    func getFilmDetails() -> Promise<FilmDetail> {
        return Promise<FilmDetail> { seal in
            networking.request(
                method: method,
                relativeURL,
                parameters: parameters,
                headers: headers
            ).done { (result: FilmDetail) in
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}

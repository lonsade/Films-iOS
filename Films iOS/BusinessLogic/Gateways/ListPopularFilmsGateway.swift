//
//  ListPopularFilmsGateway.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IListPopularFilmsGateway: class {
    func getPopularFilms() -> Promise<[FilmCard]>
}

final class ListPopularFilmsGateway: IListPopularFilmsGateway {

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

    func getPopularFilms() -> Promise<[FilmCard]> {
        return Promise<[FilmCard]> { seal in
            var films: [FilmCard] = []
            networking.request(
                method: method,
                relativeURL,
                parameters: parameters,
                headers: headers
                ).done { (result: PopularFilms) in
                    result.results.forEach { film in
                        films.append(film)
                    }
                    seal.fulfill(films)
            }.catch { error in
                    seal.reject(error)
            }
        }
    }
}

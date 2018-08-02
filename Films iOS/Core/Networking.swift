//
//  Networking.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 02.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

protocol NetworkingProtocol {

    func request(method: RequestMethod,
                 _ relativeURL: String,
                 parameters: [String: Any]?,
                 headers: [String: String]?) -> Promise<Any?>

    func request<T: Codable>(method: RequestMethod,
                             _ relativeURL: String,
                             parameters: [String: Any]?,
                             headers: [String: String]?) -> Promise<T?>

    func request<T: Codable>(method: RequestMethod,
                             _ relativeURL: String,
                             parameters: [String: AnyObject]?,
                             headers: [String: String]?) -> Promise<[T]?>
}

final class Networking {

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func request(
        method: RequestMethod,
        _ relativeURL: String,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) -> Promise<Any?> {
        return Promise { seal in
            let URL = self.baseURL + relativeURL
            let headers = headers ?? [:]
            Alamofire.request(
                URL,
                method: method.alamofireMethod(),
                parameters: parameters,
                headers: headers
            ).validate().responseJSON { response in
                if let error = response.result.error {
                    seal.reject(error)
                } else {
                    seal.fulfill(response.result.value)
                }
            }
        }
    }

    func request<T>(
        method: RequestMethod,
        _ relativeURL: String,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) -> Promise<T?> where T: Codable {
        return Promise { seal in
            let URL = self.baseURL + relativeURL
            //let headers = headers ?? [:]

            Alamofire.request(URL).validate().responseJSON { response in
                    if let error = response.result.error {
                        seal.reject(error)
                    } else {
                        guard let value = response.result.value else {
                            return seal.reject(NetworkingError.corruptedData)
                        }
                        seal.fulfill(value as? T)
                    }
            }
        }
    }

    func request<T>(
        method: RequestMethod,
        _ relativeURL: String,
        parameters: [String: AnyObject]?,
        headers: [String: String]?
    ) -> Promise<[T]?> where T: Codable {
        return Promise { seal in
            let URL = self.baseURL + relativeURL
            let headers = headers ?? [:]
            Alamofire.request(
                URL,
                method: method.alamofireMethod(),
                parameters: parameters,
                headers: headers
            ).validate().responseJSON { response in
                if let error = response.result.error {
                    seal.reject(error)
                } else {
                    guard let value = response.result.value else {
                        return seal.reject(NetworkingError.corruptedData)
                    }
                    seal.fulfill(value as? [T])
                }
            }
        }
    }
}

enum RequestMethod: String {

    case GET, POST

    func alamofireMethod() -> Alamofire.HTTPMethod {
        switch self {
        case .GET:
            return .get
        case .POST:
            return .post
        }
    }

}

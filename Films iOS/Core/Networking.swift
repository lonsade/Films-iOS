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

protocol NetworkingProtocol: class {

    func request(method: RequestMethod,
                 _ relativeURL: String,
                 parameters: [String: Any]?,
                 headers: [String: String]?) -> Promise<Void>

    func request<T: Codable>(method: RequestMethod,
                             _ relativeURL: String,
                             parameters: [String: Any]?,
                             headers: [String: String]?) -> Promise<T>

//    func request<T: Codable>(method: RequestMethod,
//                             _ relativeURL: String,
//                             parameters: [String: Any]?,
//                             headers: [String: String]?) -> Promise<[T]>
}

final class Networking: NetworkingProtocol {

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func request(
        method: RequestMethod,
        _ relativeURL: String,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) -> Promise<Void> {
        return Promise { seal in
            let URL = self.baseURL + relativeURL
            let headers = headers ?? [:]
            Alamofire.request(
                URL,
                method: method.alamofireMethod(),
                parameters: parameters,
                headers: headers
            )
            .validate()
            .responseJSON { response in
                if let error = response.result.error {
                    seal.reject(error)
                } else {
                    seal.fulfill(print(response.result.value ?? "Invalid response data"))
                }
            }
        }
    }

    func request<T>(
        method: RequestMethod,
        _ relativeURL: String,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) -> Promise<T> where T: Codable {
        return Promise<T> { seal in
            let URL = self.baseURL + relativeURL
            let headers = headers ?? [:]
            Alamofire.request(
                URL,
                method: method.alamofireMethod(),
                parameters: parameters,
                headers: headers
            )
            .validate()
            .responseObject { (response: DataResponse<T>) in
                if let error = response.result.error {
                    seal.reject(error)
                } else {
                    guard let value = response.result.value else {
                        return seal.reject(NetworkingError.corruptedData)
                    }
                    seal.fulfill(value)
                }
            }

        }
    }

//    func request<T>(
//        method: RequestMethod,
//        _ relativeURL: String,
//        parameters: [String: Any]?,
//        headers: [String: String]?
//    ) -> Promise<[T]> where T: Codable {
//        return Promise<[T]> { seal in
//            let URL = self.baseURL + relativeURL
//            let headers = headers ?? [:]
//            Alamofire.request(
//                URL,
//                method: method.alamofireMethod(),
//                parameters: parameters,
//                headers: headers
//            )
//            .validate()
//            .responseCollection { (response: DataResponse<[T]>) in
//                if let error = response.result.error {
//                    seal.reject(error)
//                } else {
//                    guard let value = response.result.value else {
//                        return seal.reject(NetworkingError.corruptedData)
//                    }
//                    seal.fulfill(value)
//                }
//            }
//        }
//    }

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

extension DataRequest {

    @discardableResult
    func responseObject<T: Codable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void
    ) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.jsonResponseSerializerGen(),
            completionHandler: completionHandler
        )
    }

    @discardableResult
    func responseCollection<T: Codable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void
        ) -> Self {
        return response(
            queue: queue,
            responseSerializer: DataRequest.jsonArrayResponseSerializerGen(),
            completionHandler: completionHandler
        )
    }

    static func jsonResponseSerializerGen<T: Codable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(NetworkingError.networkingError) }
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            guard case let .success(validData) = result else {
                return .failure(NetworkingError.jsonCouldNotBeSerialized)
            }
            do {

                let json = try JSONDecoder().decode(T.self, from: validData)
                return .success(json)
            } catch {
                return .failure(NetworkingError.jsonCouldNotBeSerialized)
            }
        }
    }

    static func jsonArrayResponseSerializerGen<T: Codable>() -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(NetworkingError.networkingError) }
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            guard case let .success(validData) = result else {
                return .failure(NetworkingError.jsonCouldNotBeSerialized)
            }
            do {
                let json = try JSONDecoder().decode([T].self, from: validData)
                return .success(json)
            } catch {
                return .failure(NetworkingError.jsonCouldNotBeSerialized)
            }
        }
    }
}

//
//  BaseHandlerController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

typealias ConfigurationClosure = (ModuleInput) -> Void

protocol BaseHandlerController {
    func openModule(withName name: String)
    func openModule(withName name: String, configurationClosure: @escaping ConfigurationClosure)
    func closeModule()

}

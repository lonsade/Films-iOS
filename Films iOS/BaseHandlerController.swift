//
//  BaseHandlerController.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.07.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

// TODO: Перенести в Core
protocol BaseHandlerController {
    func openModule(withName name: String)
    func closeModule(withName name: String)
}

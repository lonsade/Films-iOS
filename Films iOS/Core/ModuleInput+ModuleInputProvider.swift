//
//  ModuleInput.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ModuleInput: class {
    typealias Response = (Error?) -> Void
}

protocol ModuleInputProvider: class {
    var moduleInput: ModuleInput! { get }
}

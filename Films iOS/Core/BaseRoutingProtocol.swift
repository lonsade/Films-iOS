//
//  BaseRoutingProtocol.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol BaseRoutingProtocol: class {
    func closeCurrentModule()
    var viewController: BaseHandlerController? { get set }
}

//
//  CastRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class CastRoutingAssembly: Assembly {

    var castRouting: CastRouting {
        return define(init:
            CastRouting()
        )
    }

}

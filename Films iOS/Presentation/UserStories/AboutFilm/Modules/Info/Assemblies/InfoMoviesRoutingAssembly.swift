//
//  InfoMoviesRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class InfoMoviesRoutingAssembly: Assembly {

    var infoMoviesRouting: InfoRouting {
        return define(init:
            InfoRouting()
        )
    }

}

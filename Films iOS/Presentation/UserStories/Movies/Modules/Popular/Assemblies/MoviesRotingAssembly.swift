//
//  MoviesRotingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 10.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class MoviesRotingAssembly: Assembly {

    var moviesRoting: MoviesRouting {
        return define(init: MoviesRouting())
    }
}

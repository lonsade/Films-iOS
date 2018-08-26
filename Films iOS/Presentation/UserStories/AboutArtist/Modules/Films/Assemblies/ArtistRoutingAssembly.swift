//
//  ArtistRoutingAssembly.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 12.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import EasyDi

class ArtistRoutingAssembly: Assembly {
    var artistRouting: ArtistFilmsRouting {
        return define(init:
            ArtistFilmsRouting()
        )
    }
}

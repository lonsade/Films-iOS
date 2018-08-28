//
//  AboutFilmPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol AboutFilmInput: ModuleInput {
    var id: Int? { get }
    var type: Int! { get }
    func set(id: Int, type: Int)
}

class AboutFilmPresenter: AboutFilmInput {

    var id: Int?
    var type: Int!

    func set(id: Int, type: Int) {
        self.id = id
        self.type = type
    }
}

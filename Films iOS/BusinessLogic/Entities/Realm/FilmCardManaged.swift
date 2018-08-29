//
//  FilmCardManaged.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 29.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

class FilmCardManaged: Object {
    @objc dynamic var posterPath = ""
    @objc dynamic var overview = ""
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var voteAverage: Float = 0.0
    @objc dynamic var adult = false
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension FilmCardManaged: PlainObjectConvertable {
    func toPlainObject() -> FilmCard {
        return FilmCard(
            posterPath: posterPath,
            overview: overview,
            id: id,
            title: title,
            voteAverage: voteAverage,
            adult: adult,
            name: name
        )
    }
}

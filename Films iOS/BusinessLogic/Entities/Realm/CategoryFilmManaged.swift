//
//  CategoryFilmManaged.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 30.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

class CategoryFilmManaged: Object {
    @objc dynamic var genreId = 0
    @objc dynamic var type = 0
    @objc dynamic var posterPath: String?
    @objc dynamic var overview: String?
    @objc dynamic var id = 0
    @objc dynamic var title: String?
    @objc dynamic var voteAverage: Float = 0.0
    @objc dynamic var adult = false
    @objc dynamic var name: String?

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CategoryFilmManaged: PlainObjectConvertable {
    func toPlainObject() -> CategoryFilm {
        return CategoryFilm(
            genreId: genreId,
            type: type,
            posterPath: posterPath,
            overview: overview,
            id: id,
            title: title ?? "",
            voteAverage: voteAverage,
            adult: adult ?? false,
            name: name ?? ""
        )
    }
}

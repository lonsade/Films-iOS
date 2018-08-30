//
//  Extensions.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 29.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

extension FilmCard: RealmObjectConvertable {
    func toManagedObject() -> FilmCardManaged {
        return FilmCardManaged(value: [
            "posterPath": posterPath ?? "",
            "overview": overview ?? "",
            "id": id,
            "title": title ?? "",
            "voteAverage": voteAverage,
            "adult": adult ?? "",
            "name": name ?? ""
        ])
    }
}

extension TabName: RealmObjectConvertable {
    func toManagedObject() -> TabNameManaged {
        return TabNameManaged(value: [
            "id": id,
            "name": name
        ])
    }
}

extension CategoryFilm: RealmObjectConvertable {
    func toManagedObject() -> CategoryFilmManaged {
        return CategoryFilmManaged(value: [
            "genreId": genreId,
            "type": type,
            "posterPath": posterPath ?? "",
            "overview": overview ?? L10n.notInformation,
            "id": id,
            "title": title ?? "",
            "voteAverage": voteAverage,
            "adult": adult ?? false,
            "name": name ?? ""
            ])
    }
}

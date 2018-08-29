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

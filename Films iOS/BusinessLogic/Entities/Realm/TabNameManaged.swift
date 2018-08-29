//
//  TabNameManaged.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 29.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

class TabNameManaged: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension TabNameManaged: PlainObjectConvertable {
    func toPlainObject() -> TabName {
        return TabName(name: name, id: id)
    }
}

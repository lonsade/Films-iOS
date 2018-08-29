//
//  RealmProtocols.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 29.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

protocol RealmObjectConvertable {
    associatedtype ManagedObject
    func toManagedObject() -> ManagedObject
}

protocol PlainObjectConvertable {
    associatedtype PlainObject
    func toPlainObject() -> PlainObject
}

//class RealmAccessor<T: RealmObjectConvertable> {
//    func add(objects: [T]) {
//        let realm = try! Realm()
//        try! realm.write {
//            let managedObjects = objects.map {
//                $0.toManagedObject()
//            }
//            try! realm.add(managedObjects)
//
//        }
//    }
//}

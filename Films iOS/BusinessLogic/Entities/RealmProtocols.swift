//
//  RealmProtocols.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 29.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import RealmSwift

protocol RealmObjectConvertable {
    associatedtype ManagedObject: Object
    func toManagedObject() -> ManagedObject
}

protocol PlainObjectConvertable {
    associatedtype PlainObject
    func toPlainObject() -> PlainObject
}

class RealmAccessor<T: RealmObjectConvertable> {
    func add(objects: [T]) {

        do {
            let realm = try Realm()

            try realm.write {
                let managedObjects = objects.map {
                    $0.toManagedObject()
                }
                realm.add(managedObjects, update: true)
            }
        } catch let error as NSError {
            fatalError(error.description)
        }

    }

    func add(object: T) {

        do {
            let realm = try Realm()

            try realm.write {
                realm.add(object.toManagedObject(), update: true)
            }
        } catch let error as NSError {
            fatalError(error.description)
        }

    }

    func getAll() -> Results<T.ManagedObject> {
        do {
            let realm = try Realm()
            return realm.objects(T.ManagedObject.self)
        } catch let error as NSError {
            fatalError(error.description)
        }
    }
    func get(usingQuery query: String) -> Results<T.ManagedObject> {
        do {
            let realm = try Realm()
            return realm.objects(T.ManagedObject.self).filter(query)
        } catch let error as NSError {
            fatalError(error.description)
        }
    }
}

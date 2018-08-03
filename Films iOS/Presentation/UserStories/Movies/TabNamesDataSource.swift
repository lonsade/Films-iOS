//
//  TabNamesDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 03.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IDataSource: class {
    var names: [TabName] { get }
    func addNames(names: [TabName])
}

final class TabNamesDataSource: IDataSource {
    
//    private var names: [TabName]
//    
//    func addNames(names: [TabName]) {
//        self.names = names
//    }
//
//    init() {
//
//    }

}

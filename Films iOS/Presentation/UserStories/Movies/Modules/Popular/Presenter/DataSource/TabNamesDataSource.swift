//
//  TabNamesDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 03.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ITabNamesDataSourceInput: class {
    func addNames(names: [TabName])
}

protocol ITabNamesDataSourceOutput: class {
    var names: [TabName] { get }
    var delegate: TabNamesDSDelegate? { get set }
}

final class TabNamesDataSource: ITabNamesDataSourceInput, ITabNamesDataSourceOutput {
    var names: [TabName]

    weak var delegate: TabNamesDSDelegate?

    func addNames(names: [TabName]) {
        self.names = names
        delegate?.tabNamesWasAdded(names: names)
    }

    init() {
        names = []
    }
}

protocol TabNamesDSDelegate: class {
    func tabNamesWasAdded(names: [TabName])
}
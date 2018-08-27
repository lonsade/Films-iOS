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
        self.names += [TabName(name: L10n.Movies.Tabs.inCinema, id: -2), TabName(name: L10n.Movies.Tabs.popular, id: -1)] + names
        delegate?.tabNamesWasAdded(names: self.names)
    }

    init() {
        names = []
    }
}

protocol TabNamesDSDelegate: class {
    func tabNamesWasAdded(names: [TabName])
}

//
//  MoviesRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 13.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import UIKit

protocol MoviesRoutingInput {
    func navigateToAboutFilm(onIndex index: Int)
}

final class MoviesRouting: MoviesRoutingInput {

    private var presenter: FilmsPresenterInput
    var viewController: BaseHandlerController?

    init (presenter: FilmsPresenterInput) {
        self.presenter = presenter
    }

    func navigateToAboutFilm(onIndex index: Int) {
        viewController?.openModule(withName: "AboutFilm") { moduleInput in
            guard let aboutFilminput = moduleInput as? AboutFilmInput else {
                fatalError("Could not cust moduleInput to AboutFilmInput")
            }
            aboutFilminput.set(id: self.presenter.dataSource.films[index].id)
        }
    }
}

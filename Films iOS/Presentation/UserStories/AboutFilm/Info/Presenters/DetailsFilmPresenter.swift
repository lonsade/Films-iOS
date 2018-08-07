//
//  DetailsFilmPresenter.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol IDetailsFilmPresenter: class {
    func setDetailsFilm()
}

final class DetailsFilmPresenter: IDetailsFilmPresenter {
    private var detailsFilmUsecase: IDetailsFilmUsecase
    private var dataSource: IDetailsFilmDataSourceInput

    init(detailsFilmUsecase: IDetailsFilmUsecase, dataSource: IDetailsFilmDataSourceInput) {
        self.detailsFilmUsecase = detailsFilmUsecase
        self.dataSource = dataSource
    }

    func setDetailsFilm() {
        detailsFilmUsecase.getFilmDetails().done { details in
            self.dataSource.addDetails(details: details)
        }
        .catch { error in
            fatalError(error.localizedDescription)
        }
    }
}

//
//  CastFilmDataSource.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

protocol ICastFilmDataSourceInput: class {
    func addCredits(credits: [Cast])
}

protocol ICastFilmDataSourceOutput: class {
    var credits: [Cast] { get }
    var delegate: CastFilmDataSourceCastDelegate? { get set }
}

final class CastFilmDataSource: ICastFilmDataSourceInput, ICastFilmDataSourceOutput {

    weak var delegate: CastFilmDataSourceCastDelegate?

    func addCredits(credits: [Cast]) {
        self.credits = credits
        delegate?.creditsWasAdded(credits: credits)
    }

    var credits: [Cast]

    init() {
        credits = []
    }

}

protocol CastFilmDataSourceCastDelegate: class {
    func creditsWasAdded(credits: [Cast])
}

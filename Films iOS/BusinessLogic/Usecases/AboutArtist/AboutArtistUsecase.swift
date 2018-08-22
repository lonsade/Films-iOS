//
//  AboutArtistUsecase.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 09.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation
import PromiseKit

protocol IAboutArtistUsecase: class {
    func getArtist(relativeURL: String) -> Promise<Artist>
}

final class AboutArtistUsecase: IAboutArtistUsecase {

    private var makeRequestGatewayCast: IMakeRequestGateway

    init(makeRequestGatewayCast: IMakeRequestGateway) {
        self.makeRequestGatewayCast = makeRequestGatewayCast
    }

    func getArtist(relativeURL: String) -> Promise<Artist> {
        return makeRequestGatewayCast.getResults(relativeURL: relativeURL, parameters: nil)
    }
}

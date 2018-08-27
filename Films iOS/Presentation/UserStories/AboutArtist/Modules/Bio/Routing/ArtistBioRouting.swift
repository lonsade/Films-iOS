//
//  ArtistBioRouting.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 26.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

protocol ArtistBioRoutingInput: BaseRoutingProtocol {

}

final class ArtistBioRouting: ArtistBioRoutingInput {

    weak var viewController: BaseHandlerController?

    func closeCurrentModule() {
        viewController?.closeModule()
    }
}

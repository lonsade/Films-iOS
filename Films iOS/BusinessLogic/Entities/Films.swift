//
//  PopularFilms.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 05.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct Films: Codable {
    //let page: Int
    let results: [FilmCard]
    //let totalResults: Int
    //let totalPages: Int

    enum CodingKeys: String, CodingKey {
        //case page
        case results
        //case totalResults = "total_results"
        //case totalPages = "total_pages"
    }
}

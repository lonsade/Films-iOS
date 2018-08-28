//
//  FilmDetail.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 07.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct FilmDetail: Codable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let voteAverage: Float
    let runtime: Int?
    let overview: String?
    let productionCountries: [ProductionCountry]?
    let posterPath: String?
    let video: Bool?
    let adult: Bool?

    let name: String?
    let originCountry: [String]?
    let firstAirDate: String?
    let numberOfSeasons: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case overview
        case productionCountries = "production_countries"
        case posterPath = "poster_path"
        case video
        case adult

        case name
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
        case numberOfSeasons = "number_of_seasons"
    }
}

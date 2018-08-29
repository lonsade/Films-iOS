//
//  FilmCard.swift
//  Films iOS
//
//  Created by Nikita Zhudin on 01.08.2018.
//  Copyright © 2018 Nikita Zhudin. All rights reserved.
//

import Foundation

struct FilmCard: Codable {

    let posterPath: String?
    let overview: String?
    //let releaseDate: String
    let genreIds: [Int]
    let id: Int
    //let originalTitle: String
    //let originalLanguage: String
    let title: String?
    //let backdropPath: String
    //let popularity: Float
    //let voteCount: Int
//    let video: Bool
    let voteAverage: Float
    let adult: Bool?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        //case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        //case originalTitle = "original_title"
        //case originalLanguage = "original_language"
        case title
        //case backdropPath = "backdrop_path"
        //case popularity
        //case voteCount = "vote_count"
//        case video
        case voteAverage = "vote_average"
        case adult
        case name
    }
}

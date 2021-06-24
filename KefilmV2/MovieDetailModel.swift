//
//  MovieDetailModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 24.06.2021.
//

import Foundation

struct MovieDetailModel: Codable {
    let original_title: String
    let overview: String
    let release_date: String
    let runtime: Int
    let vote_average: Double
    let poster_path: String
    let budget: Int
    let genres: [Genres]
}

struct Genres: Codable {
    let name: String
}

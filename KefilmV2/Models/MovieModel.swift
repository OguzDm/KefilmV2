//
//  MovieModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//


import Foundation

// MARK: - MovieModel
struct MovieModel: Codable {
    let results: [MovieResults]
}

struct MovieResults: Codable,Hashable {
    let id: Int
    let poster_path: String
    let original_title: String
    let backdrop_path: String?
    let popularity: Double
}



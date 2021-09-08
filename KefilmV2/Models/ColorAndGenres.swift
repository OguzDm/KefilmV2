//
//  ColorAndGenres.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 3.07.2021.
//

import Foundation
import SwiftUI

struct ColorAndGenres:Hashable {
    var id: Int
    var color: Color
    var genre: String
}

let GENRES = [
    ColorAndGenres(id: 28, color: .blue, genre: "Action"),
    ColorAndGenres(id: 12, color: .pink, genre: "Adventure"),
    ColorAndGenres(id: 16, color: .red, genre: "Animation"),
    ColorAndGenres(id: 35, color: .yellow, genre: "Comedy"),
    ColorAndGenres(id: 80, color: .purple, genre: "Crime"),
    ColorAndGenres(id: 99, color: .mint, genre: "Documentary"),
    ColorAndGenres(id: 18, color: .teal, genre: "Drama"),
    ColorAndGenres(id: 10751, color: .green, genre: "Family"),
    ColorAndGenres(id: 14, color: .brown , genre: "Fantasy"),
    ColorAndGenres(id: 36, color: .gray, genre: "History"),
    ColorAndGenres(id: 27, color: .black, genre: "Horror"),
    ColorAndGenres(id: 10402, color: .yellow, genre: "Music"),
    ColorAndGenres(id: 9648, color: .orange, genre: "Mystery"),
    ColorAndGenres(id: 10749, color: .pink, genre: "Romance"),
    ColorAndGenres(id: 878, color: .cyan, genre: "Science Fiction"),
    ColorAndGenres(id: 53, color: .gray, genre: "Thriller"),
    ColorAndGenres(id: 10752, color: .black, genre: "War"),
    ColorAndGenres(id: 37, color: .brown, genre: "Western")
]

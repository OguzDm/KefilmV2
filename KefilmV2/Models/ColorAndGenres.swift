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

//let colors: [Color] = [.blue,.pink,.red,.yellow,.purple,.mint,.teal,.green,.brown,.gray,.black,.yellow,.orange,.pink,.cyan,.gray,.black,.brown]
//let genres = ["Action","Adventure","Animation","Comedy","Crime","Documentary","Drama","Family","Fantasy","History","Horror","Music","Mystery","Romance","Science Fiction","Thriller","War","Western"]
//let ids = [28,12,16,35,80,99,18,10751,14,36,27,10402,9648,10749,878,53,10752,37]

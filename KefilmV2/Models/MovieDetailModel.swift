//
//  MovieDetailModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 24.06.2021.
//

import Foundation
import SwiftUI

struct MovieDetailModel: Codable {
    let original_title: String
    let overview: String
    let release_date: String
    let runtime: Int?
    let vote_average: Double
    let poster_path: String
    let backdrop_path: String
    let budget: Int?
    let genres: [Genres]
    let tagline: String
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
    
    var genresText:String {
        var genreText = ""
        genres.forEach { genre in
            genreText.append(contentsOf: genre.name + " ")
        }
        return genreText
    }
    
    var rating:Double {
        return vote_average * 10
    }
    
    var runTimeText: String {
        guard let runtime = runtime else {return "TBA"}
        let hour = runtime / 60
        print(runtime)
        print(hour)
        let minute = runtime - hour * 60
        let timeText = "\(hour)h \(minute)m"
        
        return timeText
    }
    
    var ratingColor: Color {
        switch Int(vote_average * 10) {
        case 0...50:
            return .red
        case 51...75:
            return .yellow
        default:
            return .green
        }
    }
}

struct Genres: Codable,Hashable {
    let name: String
}

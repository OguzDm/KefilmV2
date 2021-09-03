//
//  SimilarMovieModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 31.08.2021.
//

import Foundation
import SwiftUI

struct SimilarMovieModel: Codable {
    let results: [Similar]
}

struct Similar: Codable {
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String
    var offset: CGFloat = 0
    
    var releaseYear:String {
        let year = release_date.split(separator: "-").first?.description ?? "TBA"
        return year
    }
}

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
    let poster_path: String?
    var offset: CGFloat = 0
    
    private enum CodingKeys: String, CodingKey{case id, poster_path}
}

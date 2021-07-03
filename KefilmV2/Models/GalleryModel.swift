//
//  GalleryModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 3.07.2021.
//

import Foundation

struct GalleryModel: Codable{
    let posters: [Poster]
}
struct Poster: Codable, Hashable{
    let file_path: String
}

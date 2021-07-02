//
//  SearchModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 25.06.2021.
//

import Foundation

struct SearchModel: Codable {
    let results: [SearchResults]
}
struct SearchResults: Codable, Hashable {
    let title: String
    let id: Int
}

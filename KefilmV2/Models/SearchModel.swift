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
struct SearchResults: Codable, Hashable, Identifiable {
    let title: String
    let id: Int
    let poster_path: String?
    
    var safeImage: String {
        var imageURL = Constants.baseImageURL
        if poster_path == nil {
            imageURL = "https://via.placeholder.com/150"
        }
        else {
            imageURL = imageURL + poster_path!
        }
        
        return imageURL
    }
}

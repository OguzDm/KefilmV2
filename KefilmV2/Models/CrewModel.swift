//
//  CrewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.07.2021.
//

import Foundation

struct CrewModel: Codable {
    let cast: [Cast]
}

struct Cast: Codable, Hashable {
    let name: String
    let character: String
    let profile_path: String?
    let known_for_department: String
    
    var safeImage: String {
        var imageURL = Constants.baseLowResImageURL
        if profile_path == nil {
            imageURL = "https://via.placeholder.com/100"
        }
        else {
            imageURL = imageURL + profile_path!
        }
        
        return imageURL
    }
}

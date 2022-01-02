//
//  VideoModel.swift
//  VideoModel
//
//  Created by Oguz Demırhan on 13.09.2021.
//

import Foundation

struct VideoModel: Codable {
    let results: [VideoResult]
    
    var trailers: [VideoResult] {
        
        return results.filter{$0.type == "Trailer"}
    }
}

struct VideoResult: Codable,Hashable {
    let name: String
    let key: String
    let site: String
    let type: String
}

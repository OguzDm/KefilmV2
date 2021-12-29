//
//  Tab.swift
//  KefilmV2
//
//  Created by Oğuz Demirhan on 29.12.2021.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [

    TabItem(text: "Now Playing", icon: "film.fill", tab: .nowPlaying, color: .red),
    TabItem(text: "Popular", icon: "star.fill", tab: .popular, color: .red),
    TabItem(text: "Search", icon: "magnifyingglass", tab: .search, color: .red)

]

enum Tab: String {
    case nowPlaying
    case popular
    case search
}

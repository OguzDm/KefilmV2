//
//  ContentView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        TabView {
            NowPlayingView()
                .tabItem {
                    Label("Now Playing",systemImage: "film")
                }
            PopularMoviesView()
                .tabItem{
                    Label("Popular",systemImage: "star.fill")
                }
            SearchView()
                .tabItem{
                    Label("Search",systemImage: "magnifyingglass")
                }
        }
        .accentColor(.white)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .systemBackground
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

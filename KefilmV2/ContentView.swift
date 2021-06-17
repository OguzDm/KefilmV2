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
        }
        .accentColor(.white)
        .onAppear() {
            UITabBar.appearance().backgroundColor = .black
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

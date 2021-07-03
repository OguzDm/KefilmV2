//
//  NowPlayingView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI
import SwiftUIPager
struct NowPlayingView: View {
    @StateObject var service = Service()
    @StateObject var page: Page = .first()
    private let gridItems = [GridItem(.fixed(500))]
    var body: some View {
        
        Pager(page: self.page, data: Array(0..<service.results.count),id: \.self) { index in
            if service.results.count > 0 {
                MovieCardView(imageURL: Constants.baseImageURL + service.results[index].poster_path, name: service.results[index].original_title, id: service.results[index].id)
            }
        }
        .interactive(rotation: true)
        .interactive(scale: 0.9)
        .onAppear {
            service.fetchMovies(endpoint: .nowPlaying)
        }
        
        .background(Color(uiColor: .systemBackground))
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}

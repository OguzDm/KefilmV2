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
    @State var data = Array(0..<5)
    private let gridItems = [GridItem(.fixed(500))]
    var body: some View {
        
        Pager(page: self.page, data: self.data,id: \.self) { index in
            if service.results.count > 0 {
                MovieCardView(imageURL: Service.baseImageURL + service.results[index].poster_path, name: service.results[index].original_title)
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

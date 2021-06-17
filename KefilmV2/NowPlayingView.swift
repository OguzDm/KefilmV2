//
//  NowPlayingView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject var service = Service()
    private let gridItems = [GridItem(.fixed(500))]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if service.results.count > 0 {
                        MovieCardView(imageURL: Service.baseImageURL + service.results[0].poster_path, name: service.results[0].original_title)
                    MovieCardView(imageURL: Service.baseImageURL + service.results[1].poster_path, name: service.results[1].original_title)
                    MovieCardView(imageURL: Service.baseImageURL + service.results[2].poster_path, name: service.results[2].original_title)
                    MovieCardView(imageURL: Service.baseImageURL + service.results[3].poster_path, name: service.results[3].original_title)
                    MovieCardView(imageURL: Service.baseImageURL + service.results[4].poster_path, name: service.results[4].original_title)
                }
            }
            .onAppear {
                service.fetchMovies(endpoint: .nowPlaying)
            }
        }
            
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}

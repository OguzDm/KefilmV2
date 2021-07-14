//
//  PopularMoviesView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 20.06.2021.
//

import SwiftUI

struct PopularMoviesView: View {
    @StateObject var service = Service()
    var columns: [GridItem] =
            Array(repeating: .init(.flexible()), count: 1)
    var body: some View {
        
        ScrollView(showsIndicators:false){
            if !service.results.isEmpty {
                LazyVGrid(columns: columns, spacing: 16)  {
                    ForEach(0..<service.results.count,id:\.self) { index in
                        let imageEndPoint = service.results[index].backdrop_path ?? service.results[index].poster_path
                            
                        PopularMovieCard(name: service.results[index].original_title,
                                         imageURL: Constants.baseLowResImageURL + imageEndPoint,
                                         popularity: String(Int(service.results[index].popularity)), id: service.results[index].id)
                            .onAppear {
                                if index == service.results.count - 2 {
                                    service.fetchMovies(endpoint: .popular)
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            service.fetchMovies(endpoint: .popular)
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesView()
    }
}

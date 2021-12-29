//
//  HomePageView.swift
//  KefilmV2
//
//  Created by Oğuz Demirhan on 28.12.2021.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject var service = Service()
    
    var body: some View {
        if service.results.count > 0 {
            GeometryReader { proxy in
        TabView {
         
                ForEach(service.results,id:\.self) { item in
                    MovieCardView(imageURL: Constants.baseImageURL + item.poster_path, backgroundImageURL: Constants.baseLowResImageURL + item.poster_path, name: item.original_title, id: item.id,proxy: proxy)
                }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
            }
        }
        else {
            ProgressView()
                .onAppear {
                    service.fetchMovies(endpoint: .nowPlaying)
                }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

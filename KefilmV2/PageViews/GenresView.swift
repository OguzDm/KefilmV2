//
//  GenresView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 14.07.2021.
//

import SwiftUI
import SwiftUIPager

struct GenresView: View {
    @StateObject var viewModel = GenresViewModel()
    @StateObject var page: Page = .first()
    let id: Int
    var body: some View {
        GeometryReader { proxy in
            
            let size = proxy.size
             
            Pager(page: self.page, data: Array(0..<viewModel.genresResults.count),id: \.self) { index in
                VStack(spacing:15) {
                    CarouselCardView(image: viewModel.genresResults[index].safeImage, topOffset: 70 + 15)
                            .frame(height:size.height)
                }
            }
            .vertical()
            .onAppear {
                viewModel.fetchMoviesWithGenres(genre: id)
            }
        }
    }
}

struct CarouselCardView: View {
    
    var image: String
    var topOffset: CGFloat
    var body: some View {
        
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            let minY = proxy.frame(in: .global).minY - topOffset
            
            let progress = -minY / size.height
            
            let scale = 1 - (progress / 3)
            
            let opacity = 1 - progress
            
            ZStack{
                
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width - 30, height: size.height - 80)
                        .cornerRadius(15)
                } placeholder: {
                    Rectangle()
                        .fill(.blue)
                }
                //Image("wick")
            }
            .padding(.horizontal,15)
            .scaleEffect(minY < 0 ? scale : 1)
            .opacity(minY < 0 ? opacity : 1)
            .offset(y: minY < 0 ? -minY : 0)
        }
    }
}



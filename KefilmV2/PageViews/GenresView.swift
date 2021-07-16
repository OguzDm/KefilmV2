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
    @Environment(\.dismiss) private var dismiss
    let id: Int
    var body: some View {
        GeometryReader { proxy in
            
            let size = proxy.size
            
            VStack(spacing:0){
                RoundedRectangle(cornerRadius: 18)
                    .fill(.gray)
                    .frame(width: size.width / 10, height: 8, alignment: .center)
                    .padding(.top,16)
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onEnded({ value in
                                            if value.translation.height > 0 {
                                                dismiss()
                                            }
                                        }))
                
                Pager(page: self.page, data: Array(0..<viewModel.genresResults.count),id: \.self) { index in
                    VStack(spacing:16) {
                        CarouselCardView(image: viewModel.genresResults[index].safeImage, topOffset: 70 + 16)
                                .frame(height:size.height - 32)
                    }
                }
                .vertical()
                .onAppear {
                    viewModel.fetchMoviesWithGenres(genre: id)
                }
            }
        }
    }
    
}
struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenresView(id: 28)
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
                        .frame(width: size.width - 32, height: size.height - 50)
                        .cornerRadius(16)
                } placeholder: {
                    Rectangle()
                        .fill(.blue)
                }
            }
            .padding(.horizontal,16)
            .scaleEffect(minY < 0 ? scale : 1)
            .opacity(minY < 0 ? opacity : 1)
            .offset(y: minY < 0 ? -minY : 0)
        }
    }
}



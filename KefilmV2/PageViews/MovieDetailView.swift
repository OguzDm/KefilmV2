//
//  MovieDetailView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    let movieID: Int
    var body: some View {
        
        GeometryReader { proxy in
            
            ScrollView(showsIndicators:false){
                
                VStack {
                    if viewModel.loadingState == .ready {
                        HStack(spacing:0) {
                            VStack {                //Left Side Details
                                Button {
                                    dismiss()
                                } label: {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 40, height: 40)
                                        .overlay(Image(systemName: "chevron.backward")
                                                    .font(.system(size:24))
                                                    .foregroundColor(.primary))

                                }
                                .padding(.top,16)
                                
                                Spacer()
//                                Text("\(Int(viewModel.model!.rating))")
//                                    .font(.title3)
//                                    .foregroundColor(viewModel.model!.ratingColor)
//                                    .padding(.all, 4)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 4)
//                                            .stroke()
//                                            .fill(viewModel.model!.ratingColor)
//                                    )
//                                Divider()
//                                    .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
//                                Text(viewModel.model!.releaseYear)
//                                    .font(.title3)
//                                Divider()
//                                    .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
//                                Text(viewModel.model!.runTimeText)
//                                    .font(.title3)
//                                Divider()
//                                    .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
//                                Text("$\(viewModel.model!.budget ?? 0)")
//                                    .font(.title3)
                            }
                            .frame(width:proxy.size.width - proxy.size.width / (3/2))
                            
                            VStack { // Poster
                                
                                AsyncImage(url: URL(string: Constants.baseLowResImageURL + viewModel.model!.poster_path)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: proxy.size.width / (3/2),height: proxy.size.height / 2)
                                        .cornerRadius(96, corners: .bottomLeft)
                                        .onAppear {
                                            viewModel.poster = image
                                        }
                                } placeholder: {
                                    Rectangle()
                                        .fill(.gray.opacity(0.5))
                                        .scaledToFill()
                                        .frame(width: proxy.size.width / (3/2),height: proxy.size.height / 2)
                                        .cornerRadius(96, corners: .bottomLeft)
                                        .overlay(ProgressView())
                                }
                            }
                            .frame(width: proxy.size.width / (3/2))
                        }.frame(width: proxy.size.width)
                            .edgesIgnoringSafeArea(.top)
                           
                        HStack {
                            VStack{             //Dummy VStack
                            }
                            .frame(width:proxy.size.width - proxy.size.width / (3/2))
                            VStack(spacing:0) { // Overview genres and title
                                Text(viewModel.model!.original_title)
                                    .font(.title2)
                                    .frame(width: proxy.size.width / (3/2),alignment: .leading)
                                    .padding(.bottom,8)
                                    .padding(.top,16)
                                    .textSelection(.enabled)
                                Text(viewModel.model!.genresText)
                                    .font(.subheadline)
                                    .foregroundColor(.gray).opacity(0.5)
                                    .frame(width: proxy.size.width / (3/2),alignment: .leading)
                                    .padding(.bottom,8)
                                Text(viewModel.model!.overview)
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(width: proxy.size.width / (3/2),alignment: .leading)
                                    .textSelection(.enabled)
                                
                            }
                            .frame(width: proxy.size.width / (3/2))
                        }
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            if !viewModel.images.isEmpty {
                                LazyHStack(spacing:8){ // Gallery
                                    ForEach(viewModel.images,id:\.self) { image in
                                        AsyncImage(url:URL(string: Constants.baseLowResImageURL + "/\(image.file_path)")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                
                                                .frame(width: proxy.size.width / 1.5,height:160)
                                                .cornerRadius(8)
                                        } placeholder: {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.gray.opacity(0.5))
                                                .frame(width: proxy.size.width / 1.5,height:160)
                                                .overlay(ProgressView())
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top,16)
                        .padding(.leading,16)
                        .frame(width: proxy.size.width, height: 225)
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            if !viewModel.cast.isEmpty {
                                LazyHStack(spacing:0){
                                    ForEach(viewModel.cast,id:\.self) { cast in
                                        if cast.known_for_department == "Acting" {
                                            CrewMemberView(name: cast.name, character: cast.character, image: cast.safeImage)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.leading,16)
                        ScrollView(.horizontal,showsIndicators: false){
                            LazyHStack(spacing:8){
                                if !viewModel.videos.isEmpty {
                                    ForEach(viewModel.videos,id:\.self) { video in
                                        if video.site == "YouTube" {
                                            VideoCard(videoID:video.key,proxy: proxy)
                                        }
                                    }
                                }
                            }
                        }
                        
                        //.padding(.bottom,32)
                        .padding(.leading,16)
                        .frame(width: proxy.size.width, height: 250)
                        .padding(.bottom,32)
                        //SimilarMovieView(movieID: movieID)
                    }
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.initialize(id: movieID)
                }
                
                .frame(maxWidth:proxy.size.width,maxHeight:.infinity)
            }
            .background(viewModel.backgroundColor.brightness(colorScheme == .dark ? -0.25: 0))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

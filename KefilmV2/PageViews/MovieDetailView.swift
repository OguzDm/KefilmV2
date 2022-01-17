//
//  MovieDetailView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI
import AVKit
import WrappingStack

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    let movieID: Int
    var body: some View {
        
        GeometryReader { proxy in
            
            ScrollView(showsIndicators:false){
                
                VStack(spacing: 0) {
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
                                
                                Button {
                                    dismiss()
                                } label: {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 40, height: 40)
                                        .overlay(Image(systemName: "heart")
                                                    .font(.system(size:24))
                                                    .foregroundColor(.primary))

                                }
                                .padding(.top,16)
                                
                                if !viewModel.videos.isEmpty {
                                    Button {
                                        if UIApplication.shared.canOpenURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!){
                                            UIApplication.shared.openURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!)
                                           } else{
                                               UIApplication.shared.openURL(URL(string: Constants.baseYoutubeURL + viewModel.videos.first!.key)!)
                                           }
                                    } label: {
                                        Circle()
                                            .fill(.ultraThinMaterial)
                                            .frame(width: 40, height: 40)
                                            .overlay(Image(systemName: "play.fill")
                                                        .font(.system(size:24))
                                                        .foregroundColor(.primary))

                                    }
                                    .padding(.top,16)
                                }
                          
                                Spacer()
                                
                            }
                            .frame(width:proxy.size.width - proxy.size.width / (3/2.25))
                            
                            VStack { // Poster
                                
                                AsyncImage(url: URL(string: Constants.baseLowResImageURL + viewModel.model!.poster_path)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: proxy.size.width / (3/2.25),height: proxy.size.height / 2)
                                        .cornerRadius(106, corners: .bottomLeft)
                                        .onAppear {
                                            viewModel.poster = image
                                        }
                                } placeholder: {
                                    Rectangle()
                                        .fill(.gray.opacity(0.5))
                                        .scaledToFill()
                                        .frame(width: proxy.size.width / (3/2.25),height: proxy.size.height / 2)
                                        .cornerRadius(106, corners: .bottomLeft)
                                        .overlay(ProgressView())
                                }
                            }
                            .frame(width: proxy.size.width / (3/2.25))
                        }.frame(width: proxy.size.width)
                            .edgesIgnoringSafeArea(.top)
                           
                        HStack {
                            VStack{             //Dummy VStack
                            }
                            .frame(width:proxy.size.width - proxy.size.width / (3/2.25))
                            VStack(alignment: .leading,spacing:4) { // Overview genres and title
                                Text(viewModel.model!.original_title)
                                    .font(.title2)
                                    .frame(width: proxy.size.width / (3/2.25),alignment: .leading)
                                    .padding(.bottom,8)
                                    .padding(.top,16)
                                    .textSelection(.enabled)
                                
                             
                                HStack{
                                    Text(viewModel.model!.releaseYear)
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 4, height: 4)
                                    Text(viewModel.model!.runTimeText)
                                }
                                    
                                WrappingHStack(id:\.self,alignment: .leading,horizontalSpacing: 4,verticalSpacing: 4) {
                                    ForEach(viewModel.model!.genres,id:\.self) { genre in
                                            Text(genre.name)
                                                .padding(.all,4)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(8)
                                        
                                    }
                                }
                                .padding(.trailing,8)
                                Text(viewModel.model!.overview)
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(width: proxy.size.width / (3/2.25),alignment: .leading)
                                    .textSelection(.enabled)
                                
                            }
                            .frame(width: proxy.size.width / (3/2.25))
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
                        .padding(.leading,16)
                        .frame(width: proxy.size.width, height: 160)
                        .padding(.vertical,16)
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
                        .padding(.bottom,32)
//                        ScrollView(.horizontal,showsIndicators: false){
//                            LazyHStack(spacing:8){
//                                if !viewModel.videos.isEmpty {
//                                    ForEach(viewModel.videos,id:\.self) { video in
//                                        if video.site == "YouTube" {
//                                            VideoCard(videoID:video.key,proxy: proxy)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//
//                        //.padding(.bottom,32)
//                        .padding(.leading,16)
//                        .frame(width: proxy.size.width, height: 250)
//                        .padding(.bottom,32)
                        //SimilarMovieView(movieID: movieID)
                    }
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.initialize(id: movieID)
                }
                
                .frame(maxWidth:proxy.size.width,maxHeight:.infinity)
            }
            .background(viewModel.backgroundColor)
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

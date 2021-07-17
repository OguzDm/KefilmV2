//
//  MovieDetailView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.06.2021.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @StateObject var gallery = GalleryViewModel()
    @State var detailsLoaded = false
    @Environment(\.dismiss) private var dismiss
    let movieID: Int
    var body: some View {
        
        ScrollView(showsIndicators:false){
            
            VStack {
                if viewModel.model != nil {
                    HStack(spacing:0) {
                        VStack {                //Left Side Details
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size:24))
                                    .foregroundColor(.gray)
                            }
                            .offset(x: 0, y: -50)
                            Text("\(Int(viewModel.model!.rating))")
                                .font(.title3)
                                .foregroundColor(viewModel.model!.ratingColor)
                                .padding(.all, 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke()
                                        .fill(viewModel.model!.ratingColor)
                                )
                            Divider()
                                .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                            Text(viewModel.model!.releaseYear)
                                .font(.title3)
                            Divider()
                                .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                            Text(viewModel.model!.runTimeText)
                                .font(.title3)
                            Divider()
                                .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                            Text("$\(viewModel.model!.budget ?? 0)")
                                .font(.title3)
                        }
                        .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                        
                        VStack { // Poster
                            
                            AsyncImage(url: URL(string: Constants.baseLowResImageURL + viewModel.model!.poster_path)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width / (3/2))
                                    .cornerRadius(96, corners: .bottomLeft)
                                    .ignoresSafeArea()
                            } placeholder: {
                                Rectangle()
                                    .fill(.regularMaterial)
                                    .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2,alignment: .center)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width / (3/2))
                    }.frame(width: UIScreen.main.bounds.width)
                    
                    HStack {
                        VStack{             //Dummy VStack
                        }
                        .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                        VStack(spacing:0) { // Overview genres and title
                            Text(viewModel.model!.original_title)
                                .font(.title2)
                                .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                                .padding(.bottom,8)
                                .padding(.top,16)
                                .textSelection(.enabled)
                            Text(viewModel.model!.genresText)
                                .font(.subheadline)
                                .foregroundColor(.gray).opacity(0.5)
                                .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                                .padding(.bottom,8)
                            Text(viewModel.model!.overview)
                                .font(.body)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                                .textSelection(.enabled)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width / (3/2))
                    }
                }
                
                ScrollView(.horizontal){
                    if !gallery.images.isEmpty {
                        HStack(spacing:0){ // Gallery
                            ForEach(gallery.images,id:\.self) { image in
                                AsyncImage(url:URL(string: Constants.baseLowResImageURL + "/\(image.file_path)")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .padding(.leading,8)
                                        .frame(height:160)
                                } placeholder: {
                                    Rectangle()
                                        .fill(.gray)
                                }
                            }
                        }
                    }
                    else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .padding(.top,16)
                .onAppear {
                    gallery.fetchImages(with: movieID)
                }
                .frame(width: UIScreen.main.bounds.width, height: 225)
                
            }
            .onAppear {
                viewModel.fetchMovieDetail(id: movieID)
            }
            .background(Color(UIColor.systemBackground))
            .frame(width: UIScreen.main.bounds.width, height: .infinity)
        }
    }
}

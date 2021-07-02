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
    let movieID: Int
    var body: some View {
        ScrollView(showsIndicators:false){
        VStack {
            if viewModel.title != "" {
            HStack(spacing:0) {
                VStack {
                    Text("\(Int(viewModel.rating))")
                        .font(.title3)
                        .foregroundColor(returnColorFromRating(rating: Int(viewModel.rating)))
                        .padding(.all, 4)
                        .overlay(
                      RoundedRectangle(cornerRadius: 4)
                        .stroke()
                        .fill(returnColorFromRating(rating: Int(viewModel.rating)))
                        )
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("\(viewModel.year)")
                        .font(.title3)
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("\(viewModel.runtime)")
                        .font(.title3)
                    Divider()
                        .scaleEffect(x: 0.5, y: 2.2, anchor: .center)
                    Text("$\(viewModel.budget)")
                        .font(.title3)
                }
                .frame(width:UIScreen.main.bounds.width - UIScreen.main.bounds.width / (3/2))
                VStack {
                    
                    AsyncImage(url: URL(string: Constants.baseImageURL + viewModel.poster)) { image in
                        image
                            .resizable()
                            .scaledToFit()
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
                VStack(spacing:0) {
                    Text(viewModel.title)
                        .font(.title2)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                        .padding(.top,16)
                        .textSelection(.enabled)
                    Text(viewModel.genres)
                        .font(.subheadline)
                        .foregroundColor(.gray).opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .padding(.bottom,8)
                    Text(viewModel.overview)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .frame(width: UIScreen.main.bounds.width / (3/2),alignment: .leading)
                        .textSelection(.enabled)
                }
                .frame(width: UIScreen.main.bounds.width / (3/2))
            }
            }
            ScrollView(.horizontal){
                HStack(spacing:12){
                    if !gallery.images.isEmpty {
                        ForEach(gallery.images,id:\.self) { image in
                            AsyncImage(url:URL(string: Constants.baseImageURL + "/\(image.file_path)")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(8)
                            } placeholder: {
                                Rectangle()
                                    .fill(.gray)
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
            }
            .frame(width: UIScreen.main.bounds.width, height: 225)
            Spacer()
        }
        .onAppear {
            viewModel.fetchMovieDetail(id: movieID)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        }
    }
    func returnColorFromRating(rating: Int) -> Color {
        switch rating {
        case 0...50:
            return .red
        case 51...75:
            return .yellow
        default:
            return .green
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailView(movieID: 615457)
                .preferredColorScheme(.dark)
        }
    }
}


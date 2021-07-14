//
//  GenresView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 14.07.2021.
//

import SwiftUI

struct GenresView: View {
    @StateObject var viewModel = GenresViewModel()
    let id: Int
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.genresResults,id:\.self) { movie in
                    AsyncImage(url: URL(string: movie.safeImage)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    }
                }
            }
            .onAppear {
                viewModel.fetchMoviesWithGenres(genre: id)
            }
        }
    }
}

//struct GenresView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenresView(id: 28)
//    }
//}

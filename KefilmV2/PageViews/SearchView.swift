//
//  SearchView.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 25.06.2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    @State private var showingSheet = false
    private let gridItems = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading,8)
                TextField("Search for a Movie",
                          text: $viewModel.query,
                          onCommit: {
                    self.performSearch()
                })
                    .textFieldStyle(.plain)
                    .padding(.top,8)
                    .padding(.bottom,8)
            }
            .padding(.leading,12)
            .padding(.trailing,12)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .fill(.gray.opacity(0.5))
                    .padding(.leading,8)
                    .padding(.trailing,8)
            )
                
            VStack{
                if !viewModel.searchResults.isEmpty {
                    List{
                        ForEach(self.viewModel.searchResults, id:\.self) { movie in
                            Button(movie.title) {
                                showingSheet.toggle()
                            }
                            .sheet(isPresented: $showingSheet) {
                                        MovieDetailView(movieID: movie.id)
                                    }
                        }
                    }
                }
                else {
                    ScrollView{
                        LazyVGrid(columns:gridItems) {
                            ForEach(0...17,id:\.self) {id in
                                GenreCard(color: ColorAndGenres().colors[id], genre: ColorAndGenres().genres[id])
                            }
                        }
                    }
                }
            }
            .padding(.top,8)
            Spacer()
        }
    }
    func performSearch() {
        viewModel.searchRequest()
      }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

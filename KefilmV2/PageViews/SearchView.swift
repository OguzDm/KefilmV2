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
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.quaternary)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $viewModel.query)
                            .onChange(of: viewModel.query) { newValue in
                                viewModel.searchRequest()
                            }
                    }
                    .padding(.leading,8)
                    
                }
                .frame(height:36)
                .padding(.horizontal)
                .padding(.vertical,8)
                
                if !viewModel.searchResults.isEmpty {
                    List{
                        ForEach(self.viewModel.searchResults, id:\.self) { movie in
                            Text(movie.title)
                                .font(.avenirNext(size: 16))
                                .onTapGesture {
                                    showingSheet.toggle()
                                }
                            .fullScreenCover(isPresented: $showingSheet) {
                                        DetailPageView(movieID: movie.id)
                                    }
                        }
                    }
                   
                }
                else {
                    ScrollView{
                        LazyVGrid(columns:gridItems) {
                            ForEach(GENRES,id:\.self) {genre in
                                GenreCard(color: genre.color, genre: genre.genre,id: genre.id)
                            }
                        }
                    }
                }
            }
            Spacer()
    
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

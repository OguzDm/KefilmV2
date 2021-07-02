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
    var body: some View {
        VStack{
            TextField("Search Movie",
                      text: $viewModel.query,
                      onCommit: {
                self.performSearch()
            })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            VStack{
                if self.viewModel.searchResults.count > 0 {
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
            }
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

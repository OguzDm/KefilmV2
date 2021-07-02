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
    var body: some View {
        VStack{
            TextField("Start typing",
                      text: $viewModel.query,
                      onCommit: {
                self.performSearch()
            })
                           .textFieldStyle(RoundedBorderTextFieldStyle())
            VStack{
                if self.viewModel.searchResults.count > 0 {
                    List{
                        ForEach(self.viewModel.searchResults, id:\.self) { movie in
                            Text(movie.title)
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

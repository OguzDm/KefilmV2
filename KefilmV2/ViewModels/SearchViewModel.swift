//
//  SearchViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 25.06.2021.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchResults = [SearchResults]()
    @Published var query = ""
    @Published var isLoading = false
    
    func searchRequest() {
        if query != "" {
            guard let requestURL = URL(string: Constants.baseSearchURL + "?api_key=\(Constants.apiKey)&query=\(query)") else {return}
            let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
                
                guard let data = data else {return}
                do {
                    let results = try JSONDecoder().decode(SearchModel.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = results.results
                    }
                }
                catch(let error) {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        else {
            searchResults = [SearchResults]()
        }
   
    }
    
    func fetchMoviesWithGenres(genre id: Int){
        guard let requestURL = URL(string: Constants.baseDiscoverURL + "?api_key=\(Constants.apiKey)&sort_by=popularity.desc&with_genres=\(id)") else {return}
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let results = try JSONDecoder().decode(SearchModel.self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = results.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

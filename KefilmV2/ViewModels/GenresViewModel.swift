//
//  GenresViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 14.07.2021.
//

import Foundation

class GenresViewModel: ObservableObject {
    
    @Published var genresResults = [SearchResults]()
    
    func fetchMoviesWithGenres(genre id: Int){
        guard let requestURL = URL(string: Constants.baseDiscoverURL + "?api_key=\(Constants.apiKey)&sort_by=popularity.desc&with_genres=\(id)") else {return}
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let results = try JSONDecoder().decode(SearchModel.self, from: data)
                DispatchQueue.main.async {
                    self.genresResults = results.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

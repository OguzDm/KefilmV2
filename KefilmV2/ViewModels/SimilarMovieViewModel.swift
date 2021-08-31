//
//  SimilarMovieViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 31.08.2021.
//

import Foundation

class SimilarMovieViewModel: ObservableObject {
    
    @Published var movies = [Similar]()
    
    func fetchSimilar(with id: Int) {
        
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/similar?" + "api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            
            do {
                let similarMovies = try JSONDecoder().decode(SimilarMovieModel.self, from: data)
                DispatchQueue.main.async {
                    self.movies = similarMovies.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

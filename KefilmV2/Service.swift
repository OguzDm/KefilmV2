//
//  Service.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 17.06.2021.
//

import Foundation

class Service : ObservableObject{
    
    let apiKey = ""
    let baseURL = "https://api.themoviedb.org/3/movie/"
    static let baseImageURL = "https://image.tmdb.org/t/p/original"
    @Published var results = [MovieResults]()
    
    enum endpoint: String {
        case popular = "popular"
        case nowPlaying = "now_playing"
    }
    
    func fetchMovies(endpoint : endpoint){
        
        let requestString = baseURL + endpoint.rawValue + "?api_key=\(apiKey)"
        guard let requestURL = URL(string: requestString) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            
            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    self.results = movies.results
                }
            }
            catch(let error) {
                    print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

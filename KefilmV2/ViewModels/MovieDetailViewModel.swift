//
//  MovieDetailViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 20.06.2021.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var overview = ""
    @Published var poster = ""
    @Published var budget = 0
    @Published var year = ""
    @Published var genres = ""
    @Published var rating = 0.0
    @Published var runtime = 0
    @Published var model: MovieDetailModel?
    
    func fetchMovieDetail(id: Int) {
        guard let requestURL = URL(string: Constants.baseURL + "\(id)?api_key=" + Constants.apiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            
            do {
                let details = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                DispatchQueue.main.async {
                    self.model = details
                    self.title = details.original_title
                    self.poster = details.poster_path
                    self.budget = details.budget
                    self.overview = details.overview
                    let releaseYear = details.release_date.split(separator: "-").first?.description ?? "TBA"
                    self.year = releaseYear
                    details.genres.forEach { genre in
                        self.genres.append(genre.name + " ")
                    }
                    self.rating = details.vote_average * 10
                    self.runtime = details.runtime
                }
               
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

//
//  MovieDetailViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 20.06.2021.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var model: MovieDetailModel?
    
    func fetchMovieDetail(id: Int) {
        guard let requestURL = URL(string: Constants.baseURL + "\(id)?api_key=" + Constants.apiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            
            do {
                let details = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                DispatchQueue.main.async {
                    self.model = details
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

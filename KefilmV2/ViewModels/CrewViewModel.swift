//
//  CrewViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 19.07.2021.
//

import Foundation

class CrewViewModel: ObservableObject {
    
    @Published var cast = [Cast]()
    
    func fetchCrew(id: Int){
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/credits?api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            do {
                let cast = try JSONDecoder().decode(CrewModel.self, from: data)
                DispatchQueue.main.async {
                    self.cast = cast.cast
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

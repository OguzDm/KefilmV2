//
//  VideoViewModel.swift
//  VideoViewModel
//
//  Created by Oguz Demırhan on 13.09.2021.
//

import Foundation

class VideoViewModel: ObservableObject {
    
    @Published var videos = [VideoResult]()
    func fetchVideos(with id: Int) {
        
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/videos?" + "api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            
            guard let data = data else {return}
            
            do {
                let videos = try JSONDecoder().decode(VideoModel.self, from: data)
                DispatchQueue.main.async {
                    self.videos = videos.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

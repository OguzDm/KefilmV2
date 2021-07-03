//
//  GalleryViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 3.07.2021.
//

import Foundation

class GalleryViewModel: ObservableObject {
    @Published var images = [Poster]()
    func fetchImages(with id: Int){
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/images?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let images = try JSONDecoder().decode(GalleryModel.self, from: data)
                DispatchQueue.main.async {
                    self.images = images.backdrops
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

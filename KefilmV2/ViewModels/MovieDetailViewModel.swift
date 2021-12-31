//
//  MovieDetailViewModel.swift
//  KefilmV2
//
//  Created by Oguz Demırhan on 20.06.2021.
//

import Foundation
import SwiftUI

enum LoadingState {
    case loading
    case ready
}
final class MovieDetailViewModel: ObservableObject {
    
    @Published var model: MovieDetailModel?
    @Published var images = [Poster]()
    @Published var cast = [Cast]()
    @Published var movies = [Similar]()
    @Published var swipedCard = 0
    @Published var videos = [VideoResult]()
    @Published var loadingState: LoadingState = .loading
    @Published var poster: Image? {
        didSet{
            setAverageColor()
        }
        
    }
    @Published var backgroundColor: Color = .clear
    private let group = DispatchGroup()
    
    private func fetchMovieDetail(id: Int) {
        group.enter()
        guard let requestURL = URL(string: Constants.baseURL + "\(id)?api_key=" + Constants.apiKey) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { [weak self] data, resp, err in
            
            defer {
                self?.group.leave()
            }
            
            guard let data = data else {return}
            
            do {
                let details = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                DispatchQueue.main.async {
                    self?.model = details
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        
      
        task.resume()
        
        
    }
    
   
    private func fetchImages(with id: Int){
        group.enter()
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/images?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: requestURL) { [weak self] data, resp, err in
            defer {
                self?.group.leave()
            }
            guard let data = data else {return}
            do {
                let images = try JSONDecoder().decode(GalleryModel.self, from: data)
                DispatchQueue.main.async {
                    self?.images = images.backdrops
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
       
        task.resume()
        
       
    }
    
    
    
    private func fetchCrew(id: Int){
        group.enter()
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/credits?api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) {[weak self] data, resp, err in
            defer {
                self?.group.leave()
            }
            guard let data = data else {return}
            do {
                let cast = try JSONDecoder().decode(CrewModel.self, from: data)
                DispatchQueue.main.async {
                    self?.cast = cast.cast
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
    
   
    
    private func fetchSimilar(with id: Int) {
        group.enter()
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/similar?" + "api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { [weak self] data, resp, err in
            
            defer {
                self?.group.leave()
            }
            
            guard let data = data else {return}
            
            do {
                let similarMovies = try JSONDecoder().decode(SimilarMovieModel.self, from: data)
                DispatchQueue.main.async {
                    self?.movies = similarMovies.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
       
    }
    
   
    private func fetchVideos(with id: Int) {
        group.enter()
        guard let requestURL = URL(string: Constants.baseURL + "\(id)/videos?" + "api_key=" + Constants.apiKey ) else {return}
        
        let task = URLSession.shared.dataTask(with: requestURL) { [weak self] data, resp, err in
            
            defer {
                self?.group.leave()
            }
            
            guard let data = data else {return}
            
            do {
                let videos = try JSONDecoder().decode(VideoModel.self, from: data)
                DispatchQueue.main.async {
                    self?.videos = videos.results
                }
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
        
    }
    
    func initialize(id: Int) {
        fetchMovieDetail(id: id)
        fetchImages(with: id)
        fetchCrew(id: id)
        fetchVideos(with: id)
        
        group.notify(queue: .main) { [weak self] in
            self?.loadingState = .ready
        }
    }
    
    func setAverageColor(){
        let uiColor = poster?.asUIImage().averageColor ?? .systemBackground
            backgroundColor  = Color(uiColor)
        }
    
}

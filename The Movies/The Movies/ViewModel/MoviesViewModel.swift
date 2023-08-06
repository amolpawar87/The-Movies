//
//  MoviesViewModel.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import Foundation

protocol TopMovies {
    func getTopMovies(completionHandler: @escaping(_ result: MovieResponse?)->Void)
}

struct MoviesDataModel {
    struct MovieData: Identifiable {
        var id: Int
        var posterPath: String?
    }
    var topMoviesList: [MovieData]?
    var showAlert: Bool = false
}

class MoviesViewModel: ObservableObject, TopMovies {
    @Published var movieDataModel: MoviesDataModel = MoviesDataModel()
    private let movieResources: MoviesResources?
    var numberOfMovies: Int
    
    init(numberOfMovies: Int, movieResources: MoviesResources) {
        self.numberOfMovies = numberOfMovies
        self.movieResources = movieResources
        getTopMovies()
    }
    
    convenience init() {
        self.init(numberOfMovies: 10, movieResources: MoviesAPIResources())
    }
    
    func getTopMovies(completionHandler: @escaping(_ result: MovieResponse?)->Void = { _ in }) {
        self.movieResources?.getMovies() { [weak self] response in
            DispatchQueue.main.async {
                guard (response != nil) else {
                    self?.movieDataModel.showAlert = true
                    completionHandler(nil)
                    return
                }
                
                // Sort array in decending order based on movie popularity so that popular movies will pop up and then we can get top 10 movies
                let responseList = response?.results
                    .sorted(by: {$0.popularity > $1.popularity})
                    .enumerated().filter({$0.offset < self?.numberOfMovies ?? 0})
                    .map({$0.element})
                
                let movies = responseList?.map({ element in
                    MoviesDataModel.MovieData(id: element.id, posterPath: element.posterPath)
                })
                self?.movieDataModel.topMoviesList = movies
                completionHandler(response)
            }
        }
    }
    
    deinit {
        debugPrint("deinitialized MoviesViewModel")
    }
}

//
//  MovieDetailsViewModel.swift
//  The Movies
//
//  Created by Apple on 01/08/23.
//

import Foundation
protocol MovieDetails {
    func getMoviesDetails(completionHandler: @escaping(_ result: MovieDetailResponse?)->Void)
}

struct MovieDetailsDataModel {
    var movieDetails: MovieDetailResponse?
    var showAlert: Bool = false
}


class MovieDetailsViewModel: ObservableObject, MovieDetails {
    @Published var movieDetailsDataModel: MovieDetailsDataModel = MovieDetailsDataModel()
    private let movieDetailResources: MoviesDetailsResources
    var movieId: Int
    
    init(movieId: Int, movieDetailResources: MoviesDetailsResources) {
        self.movieId = movieId
        self.movieDetailResources = movieDetailResources
    }
    
    convenience init() {
        self.init(movieId: 1, movieDetailResources: MoviesDetailsAPIResources())
    }
    
    func getMoviesDetails(completionHandler: @escaping(_ result: MovieDetailResponse?)->Void = { _ in }) {
        self.movieDetailResources.getMoviesDetails(movie_id: self.movieId) { [weak self] response in
            debugPrint(response as Any)
            DispatchQueue.main.async {
                guard (response != nil) else {
                    self?.movieDetailsDataModel.showAlert = true
                    completionHandler(nil)
                    return
                }
                self?.movieDetailsDataModel.movieDetails = response
                completionHandler(response)
            }
        }
    }
    
    deinit {
        debugPrint("deinitialzed MovieDetailsViewModel")
    }
}

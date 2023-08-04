//
//  MovieDetailsResources.swift
//  The Movies
//
//  Created by Apple on 04/08/23.
//

import Foundation

protocol MoviesDetailsResources {
    func getMoviesDetails(movie_id: Int, completionHandler:@escaping(_ result: MovieDetailResponse?)->Void)
}

struct MoviesDetailsAPIResources: MoviesDetailsResources {
    func getMoviesDetails(movie_id: Int, completionHandler:@escaping(_ result: MovieDetailResponse?)->Void) {

        guard let url: URL =  URL(string: "\(APICONSTANT.GET_MOVIE_DETAILS)\(movie_id)") else {
            _ = completionHandler(nil)
            return
        }
        
        APIManager.shared.getApiData(requestUrl: url, resultType: MovieDetailResponse.self) { response in
            _ = completionHandler(response)
        }
    }
}

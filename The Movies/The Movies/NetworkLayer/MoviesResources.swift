//
//  MoviesResources.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import Foundation

protocol MoviesResources {
    func getMovies(completionHandler:@escaping(_ result: MovieResponse?)->Void)
}

struct MoviesAPIResources: MoviesResources {
    
    func getMovies(completionHandler: @escaping(_ result: MovieResponse?)->Void) {

        guard let url: URL =  URL(string: APICONSTANT.GET_POPULAR_MOVIES) else {
            _ = completionHandler(nil)
            return
        }
        
        APIManager.shared.getApiData(requestUrl: url, resultType: MovieResponse.self) { response in
            _ = completionHandler(response)
        }
    }
}


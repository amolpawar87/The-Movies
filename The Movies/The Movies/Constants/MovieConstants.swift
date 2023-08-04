//
//  MovieConstants.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import Foundation

struct APICONSTANT {
    static let GET_POPULAR_MOVIES = "https://api.themoviedb.org/3/movie/popular"
    static let GET_MOVIE_DETAILS = "https://api.themoviedb.org/3/movie/"
}

struct IMAGE_CONSTANT {
    static let imageBaseURL = "https://image.tmdb.org/t/p/original"
}

struct API_ACCESS_TOKEN {
    static func getAccessToken() -> String {
        let path = Bundle.main.path(forResource: "Movie", ofType: "plist") ?? ""
        let plistDict = NSDictionary(contentsOfFile: path)
        let token = plistDict?["API_ACCESS_TOKEN"] as? String ?? ""
        return token
    }
}

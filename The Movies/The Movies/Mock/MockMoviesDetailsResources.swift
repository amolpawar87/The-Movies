//
//  MockMoviesDetailsResources.swift
//  The Movies
//
//  Created by Apple on 04/08/23.
//

import Foundation

class MockMoviesDetailsResources: MoviesDetailsResources {
    func getMoviesDetails(movie_id: Int, completionHandler: @escaping (MovieDetailResponse?) -> Void) {
        guard let path = Bundle.main.path(forResource: "MockMovieDetails", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
            _ = completionHandler(result)
        } catch {
            print(error)
            _ = completionHandler(nil)
        }
    }
}

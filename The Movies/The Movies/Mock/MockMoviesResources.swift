//
//  MockMoviesResources.swift
//  The MoviesTests
//
//  Created by Apple on 03/08/23.
//

import Foundation
class MockMoviesResources: MoviesResources {
    
    func getMovies(completionHandler: @escaping (MovieResponse?) -> Void) {
        guard let path = Bundle.main.path(forResource: "MockMovieResource", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(MovieResponse.self, from: data)
            _ = completionHandler(result)
        } catch {
            print(error)
            _ = completionHandler(nil)
        }
    }
}

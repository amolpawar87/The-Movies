//
//  MoviesAPIResourceUnitTests.swift
//  The MoviesTests
//
//  Created by Apple on 31/07/23.
//

import XCTest
@testable import The_Movies

final class MoviesAPIResourceUnitTests: XCTestCase {

    
    func test_PopularMoviesApiResource_Returns_MoviesResponse(){
        // ARRANGE
        let noofMoviesTobeShown = 10
        let viewModel = MoviesViewModel(numberOfMovies: noofMoviesTobeShown, movieResources: MockMoviesResources())
        let expectation = self.expectation(description: "ValidRequest_Returns_ResponseWithPopularMovies")
        
        // ACT
        viewModel.getTopMovies { response in
            // ASSERT
            XCTAssertNotNil(response, "response should not be nil")
            XCTAssertNotNil(response?.results.first?.id, "Movie Id should not be nil")
            XCTAssertEqual(viewModel.movieDataModel.topMoviesList?.count, noofMoviesTobeShown, "Will show top 10 movies")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_MovieDetailApiResource_With_MovieId_Returns_MovieDetailResponse(){

        // ARRANGE
        let viewModel = MovieDetailsViewModel(movieId: 346698, movieDetailResources: MockMoviesDetailsResources())
        let expectation = self.expectation(description: "ValidRequest_Returns_ResponseWithMovieDetails")

        // ACT
        viewModel.getMoviesDetails { (response) in

            // ASSERT
            XCTAssertNotNil(response, "response should not be nil")
            XCTAssertEqual(346698, response?.id, "Movie Id should be equal")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_MovieDetailApiResource_With_InValidMovieId_Returns_nil_Response(){

        // ARRANGE
        let viewModel = MovieDetailsViewModel(movieId: 34669, movieDetailResources: MockMoviesDetailsResources())
        let expectation = self.expectation(description: "InValidMovieId_Returns_nil_Response")

        // ACT
        viewModel.getMoviesDetails { (response) in

            // ASSERT
            XCTAssertNotEqual(34669, response?.id, "Movie Id not be equal")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

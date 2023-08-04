//
//  ContentView.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var movieViewModel = MoviesViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(movieViewModel.movieDataModel.topMoviesList ?? [], id: \.id) {
                        movie in
                        ZStack {
                            NavigationLink(destination: MovieDetailsView(movieViewModel: MovieDetailsViewModel(movieId: movie.id, movieDetailResources: MoviesDetailsAPIResources()))) {
                                EmptyView()
                            }
                            MoviesRow(theMovie: movie)
                        }
                    }
                    .listRowInsets(EdgeInsets()) // to remove default padding
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }.navigationBarTitle("Top 10 Movies")
            }
        }
        .onAppear {
            movieViewModel.getTopMovies()
        }
        .alert(isPresented: $movieViewModel.movieDataModel.showAlert) {
            Alert(title: Text("Alert"), message: Text("Something went wrong"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

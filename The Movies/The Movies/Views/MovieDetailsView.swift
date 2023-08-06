//
//  MovieDetailsView.swift
//  The Movies
//
//  Created by Apple on 31/07/23.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movieViewModel = MovieDetailsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyImage(imageUrl: "\(IMAGE_CONSTANT.imageBaseURL)\(movieViewModel.movieDetailsDataModel.movieDetails?.posterPath ?? "")")
                Text(movieViewModel.movieDetailsDataModel.movieDetails?.overview ?? "")
            }
        }
        .navigationBarTitle(Text(movieViewModel.movieDetailsDataModel.movieDetails?.originalTitle ?? ""), displayMode: .inline)
        .alert(isPresented: $movieViewModel.movieDetailsDataModel.showAlert) {
            Alert(title: Text("Alert"), message: Text("Something went wrong"), dismissButton: .default(Text("OK")))
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView()
    }
}
